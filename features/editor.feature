Feature: Editor enters asset metadata
  In order to add new searchable assets
  As an editor
  I want a form to enter metadata for an asset

  Scenario: Non-editor cannot enter metadata
    Given I am logged out
    Then I should not be allowed to add new metadata

  Scenario: Editor enters metadata
    Given I am logged in
    Then I should be on the new asset page
