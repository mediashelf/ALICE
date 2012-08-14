Feature: Search
  In order to find law assets
  as a regular user
  I want to search for, and find results

  Scenario: Search returns basic results
    Given an asset with topic "Shark Week" and summary "I love sharks"
    When I search for "sharks"
    Then I should see "Shark Week"
