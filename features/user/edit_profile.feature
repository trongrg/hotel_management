Feature: edit profile
  As a signed in user,
  In order to change my info,
  I should be able to edit my profile

  Scenario: I sign in and edit my account
    Given I am signed in
    When I edit my account details
    Then I should see an account edited message
