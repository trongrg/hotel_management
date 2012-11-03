Feature: hotel owner remove a staff member from hotel
  In order to fire a staff member,
  As a hotel owner,
  I should be able to remove a staff member from my hotel

  Background:
    Given I am signed in as a hotel owner with username: "trongrg"
    And user "trongrg" has a hotel with name: "Thien An"
    And a user exists with:
      | username | vannguyen |
    And user "vannguyen" is a staff member of hotel "Thien An"

  Scenario: remove staff member
    When I go to the hotel staff index page of hotel "Thien An"
    Then I should see 1 staff member
    When I follow "Remove" link of user "vannguyen"
    And I accept the confirm box
    Then I should see a successful remove user message
    And I should be on the hotel staff index page of hotel "Thien An"
    But I should not see "vannguyen"
