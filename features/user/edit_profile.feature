Feature: edit profile
  As a signed in user,
  In order to change my info,
  I should be able to edit my profile

  Background:
    Given I am signed in

  Scenario: I edit my profile details
    When I edit my profile
    Then I should see a successful update your profile message
    And I should be on the homepage

  Scenario: I edit my profile without a first name
    When I edit my profile without a first name
    Then I should see a missing user's first name message

  Scenario: I edit my profile without an address
    When I edit my profile without an address
    Then I should see a successful update your profile message

  Scenario: I update my password
    When I change my password to "newpass"
    Then I should see a successful update your password message
    When I sign out
    And I sign in with password "newpass"
    Then I should see a successful sign in message
    And I should be signed in

  Scenario: I update my password with invalid current password
    When I update my password with invalid current password
    Then I should see an invalid user's current password message

  Scenario: I update my password with mismatched password
    When I update my password with mismatched password and confirmation
    Then I should see a mismatched password message
