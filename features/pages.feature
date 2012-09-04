Feature: Pages
  Scenario: Navigation links ordered by position
    Given I am logged in
    And a page "Contact" exists with position 2
    And a page "About Us" exists with position 1
    When I am on the home page
    Then I should see "About Us" before "Contact" in the main navigation

  Scenario: Page contents are displayed
    Given a page "About Us" exists with body "We are awesome"
    And I am on the home page
    When I follow "About Us"
    Then I should see "We are awesome"

  Scenario: Child pages are ordered on parent page
    Given a page "About Us" exists
    And a child page "Contact" exists with parent "About Us" and position 2
    And a child page "Survey" exists with parent "About Us" and position 1
    And I am on the home page
    When I follow "About Us"
    Then I should see "Survey" before "Contact" in the page subnavigation
