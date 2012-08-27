Feature: Sub Areas
  In order to organize assets into sub areas
  As an editor
  I want to create and maintain sub areas

  Scenario: editor creates sub area
    Given an "Immigration" policy area
      And I am logged in
    When I follow "plus_button" within ".policy_area"
    Then I should be on the new sub area page
    When I fill in "Name" with "Test Sub Area"
      And I fill in "Description" with "Sub Area Description"
      And I press "Save"
    Then I should see "Test Sub Area" within "#hierarchy"
      Then I should see "Sub Area Description"

  Scenario: anonymous user cannot create sub area
    Given I am on the sub areas page
      And I am logged out
    When I follow "New Sub Area"
    Then I should be on the sign in page
