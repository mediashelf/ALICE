Feature: Pages
  Scenario: Navigation links ordered by position
    Given I am logged in
    And a page "Contact" exists with position 2
    And a page "About Us" exists with position 1
    When I am on the home page
    Then I should see "About Us" before "Contact"
