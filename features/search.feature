Feature: Search
  In order to find law assets
  as a regular user
  I want to search for, and find results

  Background:
    Given an asset with title "Shark Week" and summary "I love sharks"

  Scenario: Search returns basic results
    When I search for "sharks"
    Then I should see "Shark Week"

  Scenario: Search returns basic results
    When I search for "elephant"
    Then I should not see "Shark Week"
