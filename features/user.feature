@javascript
Feature: User behavior
  In order to administer users and content
  As a user
  I want to log in

  Scenario: User logs in
    Given I log in
    Then I should be logged in
      And I should be on the homepage

  Scenario: User logs out
    Given I am logged in
    When I follow "Log Out"
    Then I should be logged out
      And I should be on the homepage
