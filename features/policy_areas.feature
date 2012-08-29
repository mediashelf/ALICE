Feature: Policy Areas
  In order to organize assets into broad policy areas
  As an editor
  I want to create and maintain policy areas

  @wip
  Scenario: Editor creates policy area
    Given I am logged in
    When I follow "Create new Policy Area"
      And I fill in "Name" with "Test Policy Area"
      And I fill in "Description" with "Policy Area Description"
      And I press "Save"
    Then I should see "Policy Area Description"
      And I should see "Test Policy Area" within "#hierarchy"

  Scenario: anonymous user cannot create policy area
    Given I am on the policy areas page
      And I am logged out
    When I follow "New Policy Area"
    Then I should be on the sign in page
