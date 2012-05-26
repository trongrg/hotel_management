Feature: user list reservations
  In order to manage reservations,
  As a user,
  I should be able to list all/active/expired reservations

  Background:
    Given I am signed in as a hotel owner with username: "trongrg"
    And user "trongrg" has a hotel with name: "Thien An"
    And hotel "Thien An" has a room type with name: "Deluxe"
    And room type "Deluxe" has a room with number: "101"
    And room "101" has a reservation with status: "Active"
    And room "101" has a reservation with status: "Expired"

  Scenario: list all reservations
    When I go to the room reservations page of room "101"
    Then I should see 2 reservations

  Scenario: list all expired reservations
    When I go to the room reservations page of room "101", status "expired"
    Then I should see 1 reservations

  Scenario: list all active reservations
    When I go to the room reservations page of room "101", status "active"
    Then I should see 1 reservations
