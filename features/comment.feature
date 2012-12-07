Feature: add comment to post

  Scenario: Add valid comment to post
    When I go to post page
    And I add valid comment
    Then I should see valid comment on main page

  Scenario: Add invalid comment to post
    When I go to post page
    And I add invalid comment
    Then I shouldn't see invalid comment on main page
    And comment form filled by invalid comment
    And see comment error