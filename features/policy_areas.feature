Feature: Policy Areas
  In order to organize assets into broad policy areas
  As an editor
  I want to create and maintain policy areas

  Scenario: editor creates policy area
    Given I am logged in
      And I am on the policy areas page
    When I follow "New Policy Area"
      And I fill in "Name" with "Test Policy Area"
      And I fill in "Description" with "Policy Area Description"
      And I press "Save"
    Then I should see "Test Policy Area"
      And I should see "Policy Area Description"

  Scenario: anonymous user cannot create policy area
    Given I am on the policy areas page
      And I am logged out
    When I follow "New Policy Area"
    Then I should be on the sign in page
