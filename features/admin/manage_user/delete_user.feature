Feature: admin delete user
  As an admin
  In order to manage users of the web app
  I should be able to delete a user

  Background:
    Given I am signed in as an admin user

  Scenario: delete a user
    And the following users exist
      |username|email|
      |user1|user1@test.com|
      |user2|user2@test.com|
    When I go to the users page
    And I follow "Delete" link of user "user1"
    And I accept the confirm box
    Then I should see a successful delete user message
    And I should be on the users page
    And I should not see "user1@test.com"

