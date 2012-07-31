@javascript
Feature: User logs in
  In order to administer users and content
  As a user
  I want to log in

  Scenario: User logs in
    Given there is a user named "test@example.com"
    When I am on the sign in page
    And I fill in "user_email" with "test@example.com"
    And I fill in "user_password" with "password"
    Then I should be logged in
