Feature: user edit reservation
  In order to manage reservations,
  As a user,
  I should be able to edit active reservations

  Background:
    Given I am signed in as a hotel owner
    And I have a hotel with name: "Thien An"
    And hotel "Thien An" has a reservation with id: "1"

  Scenario: edit reservation
    When I go to the edit hotel reservation page of hotel "Thien An", reservation "1"
    And I edit the reservation with valid info
    Then I should see a successful update reservation message
