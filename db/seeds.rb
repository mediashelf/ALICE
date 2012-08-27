require 'csv'
require 'rsolr'

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

def load_assets_from_csv
  opts = {:headers => true, :header_converters => :symbol}
  CSV.foreach("#{Rails.root}/support/website_assets_civil_rights_clean.csv", opts) do |row|
    Asset.create!(format: row[:format],
                  level: row[:level],
                  policy_area: row[:policy_area],
                  source: row[:source],
                  state: row[:state],
                  sub_area: row[:sub_area],
                  summary: row[:summary],
                  title: row[:title],
                  topic: row[:topic],
                  type_of: row[:type_of],
                  year: row[:year])
  end
end

def build_mock_hierarchy_from_csv
  opts = {:headers => true, :header_converters => :symbol}
  CSV.foreach("#{Rails.root}/support/website_assets_civil_rights_clean.csv", opts) do |row|
    policy_area = PolicyArea.find_by_name(row[:policy_area])
    sub_area = SubArea.find_by_name(row[:sub_area])
    topic = Topic.find_by_name(row[:topic])
    if policy_area
      if sub_area
        unless topic
          sub_area.topics.create!(name: row[:topic])
        end
      else
        policy_area.sub_areas.create!(name: row[:sub_area])
      end
    else
      PolicyArea.create!(name: row[:policy_area])
    end
  end
end

create_admin

clear_assets_and_index!
clear_hierarchy!

build_mock_hierarchy_from_csv
load_assets_from_csv
