Feature: Hierarchy
  In order to use the topics hierarchy when it makes sense
  As a user
  I want the hierarchy to appear and disappear based on context

  Scenario: hierarchy is context dependent
    When I am on the home page
    Then Verify hierarchy presence as follows:
      | page           | present |
      | sign in          | no      |

    When I am logged in
    Then Verify hierarchy presence as follows:
      | page           | present |
      | home           | yes      |
      | new asset      | yes     |
      | new policy area | yes |
      | new sub area   | yes |
      | new topic      | yes |
      # | search         | yes     |
      # | search results | yes     |
