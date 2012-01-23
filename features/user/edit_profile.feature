Feature: edit profile
  As a signed in user,
  In order to change my info,
  I should be able to edit my profile

  Background:
    Given I am signed in

  Scenario: I sign in and edit my account
    When I edit my account details
    Then I should see an account edited message
    And I should be on the dashboard page

  Scenario: I sign in and edit my account with invalid email
    When I edit my account details with invalid email
    Then I should see an invalid email message

  Scenario: I sign in and edit my account without an email
    When I edit my account details without an email
    Then I should see a missing user's email message
