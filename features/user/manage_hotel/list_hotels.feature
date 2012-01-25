Feature: user view hotel list
  In order to manage my hotels
  As a hotel owner
  I should be able to view the hotel list

  Background:
    Given I am signed in as a admin with username: "trongrg"

  Scenario: list hotel without pagination
    And user "trongrg" owns 3 hotels
    When I go to the user hotels page of user "trongrg"
    Then I should see 3 hotels

  Scenario: list hotel with pagination
    And user "trongrg" owns 30 hotels
    When I go to the user hotels page of user "trongrg"
    Then I should see 25 hotels
    And I should see "Next" link
    And I should see "2" link
    When I follow "Next"
    Then I should see 5 hotels

  Scenario: see 'New Hotel' link
    When I go to the user hotels page of user "trongrg"
    Then I should see "New Hotel" link
    When I follow "New Hotel"
    Then I should be on the new user hotel page of user "trongrg"
