Feature: correct layout
  As a signed in user,
  In order to easily use the website,
  I should see correct application layout

  Scenario: correct 'Sign out' link
    Given I am signed in
    When I go to the dashboard page
    Then I should see "Sign out" link
    When I follow "Sign out"
    Then I should be signed out

  Scenario: correct welcome page
    When I go to the homepage
    Then I should see "Sign up" link
    And I should see "Sign in" link

  Scenario: correct "Profile" link
    Given I am signed in
    When I go to the dashboard page
    Then I should see "Profile" link
    When I follow "Profile"
    Then I should be on the profile page
