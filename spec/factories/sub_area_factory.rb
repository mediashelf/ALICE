# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sub_area do
    name "sub area name"
    description "sub area description"

    trait :with_policy_area do
      policy_area
    end
  end
end
