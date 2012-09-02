require 'csv'
require 'faker'
require 'rsolr'
require 'factory_girl'

# Use this to seed a development, or staging database for playing around.
# NOT intended for starting a real, production database

def create_admin
  unless User.find_by_email('admin@example.com')
    User.create! email: 'admin@example.com', password: 'password'
  end
end

def clear_assets_and_index!
  Asset.delete_all

  rsolr = RSolr.connect(url: Blacklight.solr_config[:url])
  rsolr.delete_by_query('*:*')
  rsolr.commit
end

def clear_hierarchy!
  PolicyArea.delete_all
  SubArea.delete_all
  Topic.delete_all
end

def build_fake_hierarchy
  100.times do |n|
    policy_area = FactoryGirl.create(:policy_area, name: "#{Faker::Company.name} #{n}")
    sub_area = FactoryGirl.create(:sub_area, name: "#{Faker::Name.first_name} #{n}")

    sub_area.policy_area = policy_area
    sub_area.save!

    topic = FactoryGirl.create(:topic, name: "#{Faker::Name.last_name} #{n}")

    topic.sub_areas << sub_area
    topic.save!

    asset = FactoryGirl.create(:asset,
                               title: Faker::Internet.user_name,
                               topic_ids: [topic.id],
                               format: Faker::Name.first_name,
                               level: Faker::Company.catch_phrase,
                               source: Faker::Company.name,
                               state: Faker::Company.name,
                               summary: Faker::Company.name,
                               title: Faker::Company.catch_phrase,
                               topic_ids: [topic.id],
                               type_of: Faker::Company.name,
                               year: rand(1..2012))
  end
end

def load_website_hierarchy
  opts = {:headers => true, :header_converters => :symbol}
  CSV.foreach("#{Rails.root}/support/website_assets/hierarchy.csv", opts) do |row|
    print '.'
    policy_area_name = row[:policy_area]
    sub_area_name = row[:sub_area]
    topic_name = row[:topic]

    policy_area = PolicyArea.find_or_create_by_name(policy_area_name) || raise("Missing Policy Area #{policy_area_name}")
    sub_area = SubArea.find_or_create_by_name(sub_area_name) || raise("Missing Sub Area #{sub_area_name}")
    topic = Topic.find_or_create_by_name(topic_name) || raise("Missing Topic #{topic_name}")

    sub_area.policy_area = policy_area unless(sub_area.policy_area == policy_area)
    sub_area.save!
    topic.sub_areas << sub_area unless(topic.sub_areas.include?(sub_area))
  end
end

def load_assets_from_csv
  opts = {:headers => true, :header_converters => :symbol}

  missing_topics = Set.new

  CSV.foreach("#{Rails.root}/support/website_assets_civil_rights_clean.csv", opts) do |row|
    topic_name = row[:topic]

    begin
      topic = Topic.find_by_name!(topic_name)
    rescue
      missing_topics << topic_name
    end

    if topic.present?
      Asset.create!(asset_file: File.new(File.expand_path(File.join(Rails.root, 'support', 'fake.doc'))) ,
                    format: row[:format],
                    level: row[:level],
                    policy_area: row[:policy_area],
                    source: row[:source],
                    state: row[:state],
                    sub_area: row[:sub_area],
                    summary: row[:summary],
                    title: row[:title],
                    topic: row[:topic],
                    topic_ids: [topic.id],
                    type_of: row[:type],
                    year: row[:year])
    end
  end

  report_missing_topics(missing_topics)
end

def report_missing_topics(missing_topics)
  puts
  puts "Missing Topics:"
  missing_topics.sort.each do |topic_name|
    puts topic_name
  end
  puts
end

create_admin

clear_assets_and_index!
clear_hierarchy!

build_fake_hierarchy
load_website_hierarchy
load_assets_from_csv
