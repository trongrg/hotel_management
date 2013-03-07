Feature: user creates reservation
  In order to operate my hotel
  As a hotel owner
  I should be able to create reservation

  Background:
    Given I am signed in as a hotel owner
    And I have a hotel with name: "Thien An"
    And hotel "Thien An" has a room type with name: "Deluxe"
    And room type "Deluxe" has a room with name: "101"

  Scenario: Create reservation
    When I go to the new hotel reservation page of hotel "Thien An"
    And I create a new reservation with rooms: "101"
    Then I should see a successful create reservation message
