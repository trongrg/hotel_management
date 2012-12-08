Feature: Sign in
  In order to get access to protected sections of the site
  A user
  Should be able to sign in

  Scenario: User is not signed up
    Given I do not exist as a user
    When I sign in with valid credentials
    Then I should see an invalid sign in message
    And I should be on the sign in page

  Scenario: User enters wrong password
    Given I exist as a user
    And I am not signed in
    When I sign in with a wrong password
    Then I should see an invalid sign in message
    And I should be on the sign in page

  Scenario: User signs in successfully with email
    Given I exist as a user
    And I am not signed in
    When I sign in with valid credentials
    Then I should see a successful sign in message
    And I should be signed in
