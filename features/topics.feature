Feature: Topics
  In order to organize assets by topics
  As an editor
  I want to create and maintain topics

  Scenario: editor creates topic from hierarchy
    Given an "Immigration Rights" sub area under a policy area
      And I am logged in
    When I click the new topic button through the hierarchy
      And I fill in "Name" with "Tuition & Aid for Qualified Undocumented Students"
      And I fill in "Description" with "Test Description"
      And I press "Save"
    Then I should see "Test Description"
      And I should see "Tuition & Aid for Qualified Undocumented Students" within "#hierarchy"
      And topic "Tuition & Aid for Qualified Undocumented Students" should belong to sub area "Immigration Rights"

  Scenario: editor updates topic
    Given an "Immigration Rights" sub area under a policy area
      And topic "Tuition & Aid for Qualified Undocumented Students" under sub area "Immigration Rights"
      And I am logged in
    When I click to edit a topic in the hierarchy
      And I fill in "Name" with "Different Name"
      And I press "Save"
    Then the "Different Name" topic should belong to sub area "Immigration Rights"


  Scenario: anonymous user cannot create topic
    Given an "Immigration Rights" sub area under a policy area
      And I am on the homepage
      And I am logged out
    Then I should not see the ".plus_button" element within ".sub_area"
