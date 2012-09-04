class Fixtures
  include ActionDispatch::TestProcess
end

FactoryGirl.define do
  factory :asset do
    alternative_terms 'Asset'
    asset_file { Fixtures.new.fixture_file_upload("#{Rails.root}/support/fake.pdf", 'application/pdf') }
    bill_number 'Asset'
    external_link_to_asset 'Asset'
    format 'Asset'
    legislative_history 'Asset'
    level 'Asset'
    notes 'Asset'
    short_title 'Asset'
    source 'Asset'
    source_website 'Asset'
    state 'Asset'
    summary 'Asset'
    title 'Asset'
    type_of 'Asset'
    year 2012
    topics { [Topic.find_or_create_by_name('Right to a hearing')] }
  end
end
