Feature: delete reservation
  In order to manage reservation
  As a user,
  I should be able to delete active reservation only

  Background:
    Given I am signed in as a hotel owner
    And I have a hotel with name: "Thien An"
    And hotel "Thien An" has a reservation with status: "Active"

  Scenario: delete active reservation
    When I go to the hotel reservations page of hotel "Thien An"
    And I follow "Delete"
    Then I should see a successful delete reservation message
