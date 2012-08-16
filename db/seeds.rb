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

def load_assets_from_csv
  CSV.foreach("#{Rails.root}/support/website_assets_civil_rights_clean.csv", {:headers => true, :header_converters => :symbol}) do |row|
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

create_admin
clear_assets_and_index!
load_assets_from_csv
