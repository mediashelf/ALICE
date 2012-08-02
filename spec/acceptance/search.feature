@javascript @pending
Feature: Search returns basic results by content
  In order to find assets I'm interested in
  As a user
  I want search to return assets based on text in their content

  Scenario: User finds asset by content
    Given an open Solr connection
      And an empty Solr index
      And asset "Law of the Jungle" with "Lions"
      And asset "Law of the rest" with "and tigers and bears"
    Then there should be "2" assets
    When I am on the homepage
    And I search for "Lions"
    Then I should see "Law of the Jungle"
      And I should not see "Law of the rest"
