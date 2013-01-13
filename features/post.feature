Feature: posting in blog

  Scenario: Post in blog
    When I login as admin
    And I add valid post
    Then I should see valid post on main page

#  Scenario: Draft-post in blog
#    When I login as admin
#    And I add draft post
#    Then I shoudn't see draft post on main page
#    And I see draft post in admin
#
#
#  Scenario: Access denied for posting as not admin
#    When I add valid post
#    Then I shouldn't see valid post on main page