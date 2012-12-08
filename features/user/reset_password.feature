Feature: reset password
  As a user,
  In order to sign in after forgetting my password,
  I should be able to reset my password

  Background:
    Given I exist as a user

  Scenario: I forgot my password and reset it
    When I reset my password
    Then I should receive a reset password instruction email
    When I follow my reset password link
    And I set my password to "new_password"
    Then I should see "Your password was changed successfully. You are now signed in"
    When I sign out
    And I sign in with password "new_password"
    Then I should be signed in
