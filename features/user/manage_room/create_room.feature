Feature: hotel owner create hotel room
  In order to manage rooms of a hotel
  As a hotel owner
  I should be able to create a new room

  Background:
    Given I am signed in as a hotel owner with username: "trongrg"
    And user "trongrg" has a hotel with name: "Thien An"

  Scenario: create room with existing room type
    And hotel "Thien An" has a room type with name: "Deluxe"
    When I go to the new hotel room page of hotel "Thien An"
    And I create a new room with room type "Deluxe"
    Then I should see a successful create room message

  Scenario: create room without a room type
    When I go to the new hotel room page of hotel "Thien An"
    And I create a new room without a room type
    Then I should see a missing room's room type message

  Scenario: create room without a room number
    And hotel "Thien An" has a room type with name: "Deluxe"
    When I go to the new hotel room page of hotel "Thien An"
    And I create a new room without a number
    Then I should see a missing room's number message
