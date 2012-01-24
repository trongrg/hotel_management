Feature: User edits password
  In order to protect my password from being stolen
  As a user,
  I should be able to update my password

  Background:
    Given I am signed in

  Scenario: update password with valid credentials
    When I edit my password
    Then I should see a successful update password message
    And I should be on the dashboard page

  Scenario: update password with invalid current password
    When I edit my password with invalid current password
    Then I should see an invalid current password message

  Scenario: update password with mismatched password and confirmation
    When I edit my password with mismatched password and confirmation
    Then I should see a mismatched password message
