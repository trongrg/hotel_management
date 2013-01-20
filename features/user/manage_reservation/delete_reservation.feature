@wip
Feature: delete reservation
  In order to manage reservation
  As a user,
  I should be able to delete active reservation only

  Background:
    Given I am signed in as a hotel owner with username: "trongrg"
    And user "trongrg" has a hotel with name: "Thien An"
    And hotel "Thien An" has a room type with name: "Deluxe"
    And room type "Deluxe" has a room with number: "101"
    And room "101" has a reservation with id: "1", status: "Active"

  Scenario: delete active reservation
    When I go to the room reservations page of room "101"
    And I follow "Delete" link of reservation "1"
    Then I should see a successful delete reservation message

  Scenario: delete expired reservation
    And room "101" has a reservation with id: "2", status: "Expired"
    When I go to the room reservations page of room "101"
    And I follow "Delete" link of reservation "2"
    Then I should see "Cannot edit/delete expired reservation"
    And I should see 2 reservations
