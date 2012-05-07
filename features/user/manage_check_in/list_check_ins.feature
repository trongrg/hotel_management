Feature: user list check ins
  In order to manage check ins,
  As a user,
  I should be able to list all/active/expired check ins

  Background:
    Given I am signed in as a hotel owner with username: "trongrg"
    And user "trongrg" has a hotel with name: "Thien An"
    And hotel "Thien An" has a room type with name: "Deluxe"
    And room type "Deluxe" has a room with number: "101"
    And room "101" has a check in with status: "Active"
    And room "101" has a check in with status: "Expired"

  Scenario: list all check ins
    When I go to the room check ins page of room "101"
    Then I should see 2 check ins

  Scenario: list all expired check ins
    When I go to the room check ins page of room "101", status "expired"
    Then I should see 1 check ins

  Scenario: list all active check ins
    When I go to the room check ins page of room "101", status "active"
    Then I should see 1 check ins
