Feature: Hierarchy
  In order to visualize topic groupings of assets
  As a user
  I want a dynamic hierarch on the left side

  @javascript
  Scenario: Expand and Contract Policy Areas
    Given an "H1B" sub area within "Immigration"
      And I am on the home page
    Then "H1B" should not appear in the hierarchy

    When I click on policy area "Immigration"
    Then "H1B" should appear in the hierarchy

    When I click on policy area "Immigration"
    Then "H1B" should not appear in the hierarchy

  #@pending
  #Scenario: hierarchy is context dependent
  #When I am on the home page
    #Then Verify hierarchy presence as follows:
    #| page           | present |
    #| sign in          | no      |

    #When I am logged in
    #Then Verify hierarchy presence as follows:
    #| page           | present |
    #| home           | yes      |
    #| new asset      | yes     |
    #| new policy area | yes |
    #| new sub area   | yes |
    #| new topic      | yes |
      # | search         | yes     |
      # | search results | yes     |
