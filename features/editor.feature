Feature: Editor enters asset metadata
  In order to add new searchable assets
  As an editor
  I want a form to enter metadata for an asset

  Scenario: General public cannot access "new asset" page to enter an asset
    Given I am on the homepage
      And I am logged out
    Then I should not be allowed access the new asset page

  @pending
  Scenario: Editor enters metadata
    Given I am logged in
    Then I should be on the homepage
    # And I should see a link to "Create New Asset"
    # When I go to the new asset page
    # Then I should be on the new asset page
