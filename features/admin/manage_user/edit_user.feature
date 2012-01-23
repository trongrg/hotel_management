Feature: admin edit user
  As an admin
  In order to manage users of the web app
  I should be able to edit a user

  Background:
    Given I am signed in as an admin user
    And the following users exist
      |username|email|
      |user1|user1@test.com|

  Scenario: edit a user
    When I go to the users page
    And I follow "Edit" link of user "user1"
    Then I should be on the edit user page of user "user1"
    When I edit the user with valid info
    Then I should see a successful edit user message

  Scenario: edit a user with invalid email
    When I go to the edit user page of user "user1"
    And I edit the user with invalid email
    Then I should see an invalid email message

  Scenario: edit user with new password
    When I go to the edit user page of user "user1"
    And I edit the user with new password
    Then I should see a successful edit user message
    When I sign out
    And I sign in as "user1/newpass"
    Then I should be signed in

  Scenario: see 'User list' link
    When I go to the edit user page of user "user1"
    Then I should see "User list" link
    When I follow "User list"
    Then I should be on the users page
