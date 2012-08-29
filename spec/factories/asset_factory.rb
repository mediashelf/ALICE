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
    policy_area 'Asset'
    short_title 'Asset'
    source 'Asset'
    source_website 'Asset'
    state 'Asset'
    sub_area 'Asset'
    summary 'Asset'
    title 'Asset'
    topic 'Asset'
    type_of 'Asset'
    web_folder_link_to_asset_pdf 'Asset'
    web_folder_link_to_asset_word_doc  'Asset'
    web_folder_link_to_bill_pdf 'Asset'
    web_folder_link_to_bill_word_doc 'Asset'
    year 2012
  end
end
