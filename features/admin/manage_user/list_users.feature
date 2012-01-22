Feature: admin list users
  As an admin
  In order to manage users of the web app
  I should be able to see the list of users

  Background:
    Given I am signed in as an admin user

  Scenario: view list of users
    And 5 users exist
    When I go to the users page
    Then I should see 6 users

  Scenario: view list of users with pagination
    And 40 users exist
    When I go to the users page
    Then I should see 25 users
    And I should see "Next" link
    And I should see "2" link
    When I follow "Next"
    Then I should see 16 users
