Feature: list room types
  In order to manage the room of a hotel
  As a hotel owner
  I should be able to list all the rooms of a hotel

  Background:
    Given I am signed in as a hotel owner
    And I have a hotel with name: "Thien An"
    And hotel "Thien An" has a room type with name: "Deluxe"

  Scenario: list rooms without pagination
    And room type "Deluxe" has 3 rooms
    When I go to the hotel rooms page of hotel "Thien An"
    Then I should see 3 rooms

  Scenario: list rooms with pagination
    And room type "Deluxe" has 30 rooms
    When I go to the hotel rooms page of hotel "Thien An"
    Then I should see 25 rooms
    And I should see "Next" link
    And I should see "2" link
    When I follow "Next"
    Then I should see 5 rooms

  Scenario: do not show rooms of other hotel
    And I have a hotel with name: "Thien An 2"
    And hotel "Thien An 2" has a room type with name: "Deluxe 2"
    And room type "Deluxe 2" has 30 rooms
    And room type "Deluxe" has 10 rooms
    When I go to the hotel rooms page of hotel "Thien An"
    Then I should see 10 rooms

  Scenario: see 'New Room' link
    When I go to the hotel rooms page of hotel "Thien An"
    Then I should see "New Room" link
    When I follow "New Room"
    Then I should be on the new hotel room page of hotel "Thien An"
