Feature: sign up
  In order to become a hotel owner,
  As an anonymous user,
  I should be able to register

  Background:
    Given I am not signed in

  Scenario: User signs up with valid data
    When I sign up with valid user data
    Then I should see a successful sign up message
    And I should be a hotel owner

  Scenario: User signs up without address
    When I sign up without an address
    Then I should see a successful sign up message
    And I should be a hotel owner

  Scenario: User signs up with invalid email
    When I sign up with an invalid email
    Then I should see an invalid user's email message

  Scenario: User signs up without password
    When I sign up without a password
    Then I should see a missing user's password message

  Scenario: User signs up with short password
    When I sign up with a short password
    Then I should see a short password error message

  Scenario: User signs up with mismatched password and confirmation
    When I sign up with a mismatched password confirmation
    Then I should see a mismatched password message

  Scenario: User signs up without an email
    When I sign up without an email
    Then I should see a missing user's email message
