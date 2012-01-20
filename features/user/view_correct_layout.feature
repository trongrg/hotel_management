Feature: correct layout
  As a signed in user,
  In order to easily use the website,
  I should see correct application layout

  Scenario: correct 'Sign out' link
    Given I am logged in
    When I go to the dashboard page
    Then I should see "Sign out" link
    When I follow "Sign out"
    Then I should be signed out

  Scenario: correct welcome page
    When I go to the homepage
    Then I should see "Sign up" link
    And I should see "Sign in" link
