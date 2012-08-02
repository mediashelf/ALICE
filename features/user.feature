@javascript
Feature: User behavior
  In order to administer users and content
  As a user
  I want to log in

  Scenario: User logs in
    Given I log in as "test@example.com"
    Then I should be logged in
      And I should be on the homepage
