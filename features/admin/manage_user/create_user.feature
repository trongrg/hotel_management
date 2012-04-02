Feature: admin edit user
  As an admin
  In order to manage users of the web app
  I should be able to edit a user

  Background:
    Given I am signed in as an admin user

  Scenario: see 'Create user' link
    When I go to the users page
    Then I should see "Create user" link
    When I follow "Create user"
    Then I should be on the new user page

  Scenario: see 'User list' link
    When I go to the new user page
    Then I should see "User list" link
    When I follow "User list"
    Then I should be on the users page

  Scenario: create a user
    When I create a new user
    Then I should see a successful create user message
    And the new user should be a hotel owner

  Scenario: create a user without a password
    When I create a new user without a password
    Then I should see a missing user's password message

  Scenario: create a user without a username
    When I create a new user without a username
    Then I should see a missing user's username message

  Scenario: create a user with an invalid username
    When I create a new user with an invalid username
    Then I should see an invalid username message
