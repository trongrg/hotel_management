Feature: user sign out
  As a signed in user,
  In order to protect my account from unauthorized access,
  I should be able to sign out

  Scenario: User signs out
    Given I am logged in
    When I sign out
    Then I should see a signed out message
    When I return to the site
    Then I should be signed out
