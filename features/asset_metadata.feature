Feature: Asset metadata
  In order to add new searchable assets
  As an editor
  I want a form to enter metadata for an asset

  Scenario: General public cannot access "new asset" page to enter an asset
    Given I am on the homepage
      And I am logged out
    Then I should not be allowed access the new asset page

  @javascript
  Scenario: Editor enters metadata
    Given an "Immigration - H1B - Right to a hearing" hierarchy exists
      And I am logged in
    Then I should be on the homepage
    When I follow "Dashboard"
      And I follow "Assets"
      And I follow "New Asset"
    Then I should be on the new asset page

    When I fill in the following:
      | Field                                  | Value                                                        |
      | Title                                  | Wisconsin right to hearing before extradition law            |
      | Year                                   | 2011                                                         |
      | Source                                 | Wisconsin Senate                                             |
      | State                                  | WI                                                           |
      | Format                                 | Examplary                                                    |
      | Level                                  | State                                                        |
      | Type of                                | Law                                                          |
      | Summary                                | Wisconsin right to hearing before extradition law - Nuf Said |
      | Alternative terms                      | some, more, terms                                            |
      | Bill number                            | 89.9 FM                                                      |
      | External link to asset                 | http://www.google.com                                        |
      | Legislative history                    | Beautiful history                                            |
      | Notes                                  | These are notes.                                             |
      | Short title                            | Right to Hearing Before Extradition                          |
      | Source website                         | http://www.wikipedia.org                                     |

      And I select "Right to a hearing" from "Topics"
      And I attach the file "fake.pdf" to "Upload Asset PDF"
      And I attach the file "fake.pdf" to "Upload Bill PDF"
      And I press "Create Asset"
    Then I should see "Right to a hearing"
    When I follow "Download"

  Scenario: Missing Required Field
    Given I am logged in
    When I follow "Dashboard"
      And I follow "Assets"
      And I follow "New Asset"
    When I press "Create Asset"
    Then I should see "can't be blank"
