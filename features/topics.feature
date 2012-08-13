Feature: Topics
  In order to organize assets by topics
  As an editor
  I want to create and maintain topics

  Scenario: editor creates topic
    Given I am logged in
      And I am on the topics page
    When I follow "New Topic"
      And I fill in "Name" with "Test Topic"
      And I fill in "Description" with "Test Description"
      And I press "Save"
    Then I should see "Test Topic"
      And I should see "Test Description"

  Scenario: anonymous user cannot create topic
    Given I am on the topics page
      And I am logged out
    When I follow "New Topic"
    Then I should be on the sign in page
