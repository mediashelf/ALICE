require 'csv'
require 'rsolr'
require 'uri'

# Use this to seed a development, or staging database for playing around.
# NOT intended for starting a real, production database

def create_admin
  unless User.find_by_email('admin@example.com')
    User.create! email: 'admin@example.com', password: 'password'
  end
end

def create_home_page
  Page.where(title: 'Who is Alice?').first_or_create(body: %Q{
    <p><strong>ALICE is a groundbreaking resource for smart legislation.</strong></p>

    <p>ALICE is the American Legislative and Issue Campaign Exchange, a national project to develop a one-stop, Web-based library of progressive model law on a wide range of issues in state and local policy. As its name may suggest, ALICE is best understood as a partial counter to ALEC (American Legislative Exchange Council), which has been in the news recently.</p>

    <p>Like ALEC, ALICE will be a values-based non-profit, and offer model laws. But the similarities end there. Our values are to support, not destroy, economic fairness, environmental sustainability, and capable democratic government. Our models will be open to the public. And instead of corporate lobbyists, our work will be done by a growing network of public interest law and public policy professors, students, advocates, and practitioners. If you're interested in joining that network, or just receiving updates on it, please sign up above... we'll be going live soon!</p>
  }).update_attribute(:is_home_page, true)
end

def clear_assets_and_index!
  `rm -rf public/uploads/asset`
  `rm -rf public/uploads/tmp`
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

def load_website_hierarchy file_name
  opts = {:headers => true, :header_converters => :symbol}
  CSV.foreach("#{Rails.root}/support/website_assets/#{file_name}", opts) do |row|
    print '.'
    policy_area_name = row[:policy_area].try(:strip)
    sub_area_name = row[:sub_area].try(:strip)
    topic_name = row[:topic].try(:strip)
    topic_description = row[:summary].try(:strip)

    policy_area = PolicyArea.find_or_create_by_name(policy_area_name) || raise("Missing Policy Area #{policy_area_name}")
    sub_area = SubArea.find_or_create_by_name(sub_area_name) || raise("Missing Sub Area #{sub_area_name}")

    topic = Topic.find_or_create_by_name(topic_name) || raise("Missing Topic #{topic_name}")
    topic.update_attributes description: topic_description

    sub_area.policy_area = policy_area unless(sub_area.policy_area == policy_area)
    sub_area.save!
    topic.sub_areas << sub_area unless(topic.sub_areas.include?(sub_area))
  end
end

def load_assets_from_csv asset_csv_file_name
  opts = {:headers => true, :header_converters => :symbol}

  missing_topics = Set.new
  failed_asset_validations = Set.new
  failed_asset_counts = Hash.new(0)
  imported_asset_count = 0
  bad_pdfs = Set.new
  unknown_topic = Topic.find_or_create_by_name(' Unknown')

  row_num = 0
  CSV.foreach("#{Rails.root}/support/website_assets/#{asset_csv_file_name}", opts) do |row|
    row_num += 1
    row[:row_num] = row_num
    puts "#=> Parsing row number: #{row_num}"

    topic_name = row[:topic].try(:strip)

    begin
      topic = Topic.find_by_name!(topic_name)
    rescue
      topic = unknown_topic
      missing_topics << topic_name
    end

    if topic.present?
      begin
        load_asset_from_csv row, topic
        imported_asset_count += 1
      rescue ActiveRecord::RecordInvalid => e
        failed_asset_validations << [e.message, e.record.inspect]
        failed_asset_counts[e.message] += 1
      rescue ArgumentError => e
        bad_pdfs << e.message
        failed_asset_counts['Bad PDF'] += 1
      end
    end
  end

  report_missing_topics missing_topics
  report_failed_validations failed_asset_validations, failed_asset_counts
  report_bad_pdfs bad_pdfs
  report_bad_urls
  puts
  puts "Total number of successfully imported assets: #{imported_asset_count}"
end

def load_asset_from_csv row, topic
  Asset.create!(asset_file: obtain_required_file(row[:row_num], row[:upload_asset_pdf]),
                format: row[:format].try(:strip) || ' Unknown',
                level: row[:level].try(:strip) || ' Unknown',
                source: row[:source].try(:strip) || ' Unknown',
                state: row[:state].try(:strip) || ' Unknown',
                summary: row[:summary].try(:strip) || ' Unknown',
                title: row[:title].try(:strip) || ' Unknown',
                type_of: row[:type].try(:strip) || ' Unknown',
                year: row[:year] || 0,
                topic_ids: [topic.id],
                alternative_terms: row[:alternative_terms].try(:strip),
                bill_number: row[:bill_number].try(:strip),
                legislative_history: row[:legislative_history].try(:strip),
                notes: row[:internal_notes].try(:strip),
                short_title: row[:short_title].try(:strip),
                source_website: row[:source_website].try(:strip),
                bill_word: obtain_optional_file(row[:upload_word_bill]),
                bill_pdf: obtain_optional_file(row[:upload_bill_pdf]),
                asset_word: obtain_optional_file(row[:upload_word_asset]),
                external_link_to_asset: row[:external_link_to_asset].try(:strip))
  `rm -f /tmp/*.pdf /tmp/*.doc`
end

@bad_urls = []
def obtain_required_file row_num, url
  if url =~ /\.pdf|\.doc|\.txt|\.rtf|\.docx$/i
    url = URI.escape(url)
    puts "\n\n*** #{url} ***"
    file_name = url.split("/").last.gsub(/[ \(\)]/, '_')
    if system("wget \"#{url}\" -O \"/tmp/#{file_name}\"")
      pdf = File.new(File.expand_path("/tmp/#{file_name}"))
    else
      @bad_urls << "row #{row_num}: #{url}"
    end
  end
  pdf || File.new(File.expand_path(File.join(Rails.root, 'support', 'fake.doc')))
end

def obtain_optional_file url
  if url =~ /\.pdf|\.doc|\.txt|\.rtf|\.docx$/i
    url = URI.escape(url)
    puts "\n\n*** #{url} ***"
    file_name = url.split("/").last.gsub(/[ \(\)]/, '_')
    if system("wget \"#{url}\" -O \"/tmp/#{file_name}\"")
      doc = File.new(File.expand_path("/tmp/#{file_name}"))
    end
  end
  doc
end

def report_missing_topics(missing_topics)
  puts
  puts "Missing Topics:"
  missing_topics.sort.each do |topic_name|
    puts topic_name
  end
  puts
end

def report_bad_urls
  puts
  puts
  puts "Bad URLs:"
  @bad_urls.each do |url|
    puts url
  end
end

def report_bad_pdfs bad_pdfs
  puts
  puts
  puts "Bad PDFs:"
  bad_pdfs.each do |pdf|
    puts pdf
  end
end

def report_failed_validations(failed_validations, failed_counts)
  puts
  puts
  puts "#{failed_validations.count} Failed Validations:"
  failed_validations.sort.each do |validation_info|
    puts "-- #{validation_info[0]}"
    puts validation_info[1]
    puts
  end
  puts
  puts
  puts "Failed Validations Summary:"
  failed_counts.each do |message, count|
    puts "#{count}: #{message}"
  end
  puts
end

create_admin
create_home_page
clear_assets_and_index!
clear_hierarchy!

# build_fake_hierarchy
puts
puts "Loading Hierarchy"
puts
load_website_hierarchy 'hierarchy.csv'

puts
puts "Loading Assets"
puts
load_assets_from_csv 'assets.csv'
