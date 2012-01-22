Feature: anonymous user sign up
  In order to become a hotel owner,
  As an anonymous user,
  I should be able to register

  Background:
    Given I am not signed in

  Scenario: User signs up with valid data
    When I sign up with valid user data
    Then I should see a successful sign up message

  Scenario: User signs up with invalid email
    When I sign up with an invalid email
    Then I should see an invalid email message

  Scenario: User signs up without password
    When I sign up without a password
    Then I should see a missing password message

  Scenario: User signs up with short password
    When I sign up with a short password
    Then I should see a short password error message

  Scenario: User signs up with mismatched password and confirmation
    When I sign up with a mismatched password confirmation
    Then I should see a mismatched password message

  Scenario: User signs up without a username
    When I sign up without a username
    Then I should see a missing username message

  Scenario: User signs up with invalid username
    When I sign up with an invalid username
    Then I should see an invalid username message

  Scenario: User signs up without an email
    When I sign up without an email
    Then I should see a missing email message
