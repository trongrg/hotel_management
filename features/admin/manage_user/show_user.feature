Feature: admin show user
  As an admin
  In order to manage users of the web app
  I should be able to see the detail info of a user

  Background:
    Given I am signed in as an admin user
    And the following users exist
      |username|email|
      |user1|user1@test.com|

  Scenario: view a user
    When I go to the users page
    And I follow "Show" link of user "user1"
    Then I should see the info of user "user1"

  Scenario: see 'User list' link
    When I go to the user page of user "user1"
    Then I should see "User list" link
    When I follow "User list"
    Then I should be on the users page

  Scenario: see 'Edit user' link
    When I go to the user page of user "user1"
    Then I should see "Edit" link
    When I follow "Edit"
    Then I should be on the edit user page of user "user1"

  Scenario: see 'Delete user' link
    When I go to the user page of user "user1"
    Then I should see "Delete" link
    When I follow "Delete"
    And I accept the confirm box
    Then I should see a successful delete user message
    And I should be on the users page
