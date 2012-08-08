# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :asset do
    policy_area "MyString"
    sub_area "MyString"
    topic "MyString"
    asset "MyString"
    title "MyString"
    year 1
    source "MyString"
    state "MyString"
    format "MyString"
    level "MyString"
    type_of ""
    keywords "MyString"
    summary "MyString"
  end
end
