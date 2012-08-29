Feature: Admin pages
  In order to cleanly administer ALICE assets
  As an editor
  I want to add and edit content in a dashboard

  Scenario: Editor accesses dashboard
    Given I am logged in
    When I follow "Dashboard"
    Then I should be on the dashboard page

  Scenario: Editor returns to home page
    Given I am logged in
      And I am on the dashboard page
    When I follow "Alice"
    Then I am on the home page

  Scenario: Public does not see dashboard link
    Given I am on the home page
    When I am on the home page
    Then I should not see "Dashboard"

  Scenario: Public cannot link straight to dashboard
    Given I am on the home page
    When I go to the dashboard page
    Then I should be on the sign in page
