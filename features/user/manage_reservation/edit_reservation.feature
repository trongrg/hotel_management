Feature: user edit reservation
  In order to manage reservations,
  As a user,
  I should be able to edit active reservations

  Background:
    Given I am signed in as a hotel owner with username: "trongrg"
    And user "trongrg" has a hotel with name: "Thien An"
    And hotel "Thien An" has a room type with name: "Deluxe"
    And room type "Deluxe" has a room with number: "101"
    And room "101" has a reservation with id: "1", status: "Active"

  Scenario: edit reservation
    When I go to the edit room reservation page of room "101", reservation "1"
    And I edit the reservation with valid info
    Then I should see a successful update reservation message

  Scenario: edit expired reservation
    And room "101" has a reservation with id: "2", status: "Expired"
    When I go to the room reservations page of room "101"
    And I follow "Edit" link of reservation "2"
    Then I should see "Cannot edit/delete expired reservation"
    And I should be on the room reservations page of room "101"
    And I should see 2 reservations
