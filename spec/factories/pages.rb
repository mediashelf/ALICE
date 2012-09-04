FactoryGirl.define do
  factory :page do
    title "MyString"
    body "MyText"

    trait :with_children do
      children { create_list(:page, 5, parent: :page) }
    end
  end
end
