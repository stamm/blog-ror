Feature: Login

  Scenario: Unsuccessful login
    Given a user visits the login page
    When he submits invalid login information
    Then he should see a "Wrong password"

  Scenario: Successful login
    Given a user visits the login page
    And the user has an account
    And the user submits valid login information
    Then he should see his name
    And he should see a logout link