Feature: Asset metadata
  In order to add new searchable assets
  As an editor
  I want a form to enter metadata for an asset

  Scenario: General public cannot access "new asset" page to enter an asset
    Given I am on the homepage
      And I am logged out
    Then I should not be allowed access the new asset page

  Scenario: Editor enters metadata
    Given I am logged in
    Then I should be on the homepage
    When I follow "New Asset"
    Then I should be on the new asset page

    When I fill in the following:
      | Field       | Value                                                        |
      | Policy area | Immigration                                                  |
      | Sub area    | Extradition                                                  |
      | Topic       | Right to a hearing                                           |
      | Asset       | Right to a hearing law                                       |
      | Title       | Wisconsin right to hearing before extradition law            |
      | Year        | 2011                                                         |
      | Source      | Wisconsin Senate                                             |
      | State       | WI                                                           |
      | Format      | Examplary                                                    |
      | Level       | State                                                        |
      | Type of     | Law                                                          |
      | Keywords    | Immigration, Deportation                                     |
      | Summary     | Wisconsin right to hearing before extradition law - Nuf Said |

      And I attach the file "fake.pdf" to "File"
      And I press "Save"
    Then I should see "Right to a hearing law"

  Scenario: Missing Required Field
    Given I am logged in
    When I follow "New Asset"
      And I press "Save"
    Then I should see "Topic can't be blank"
      And I should see "Title can't be blank"
      And I should see "Summary can't be blank"
