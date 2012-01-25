Feature: list room types
  In order to manage the room types of a hotel
  As a hotel owner
  I should be able to list all the room types of a hotel

  Background:
    Given I am signed in as a hotel owner with username: "trongrg"
    And user "trongrg" has a hotel with name: "Thien An"

  Scenario: list room type without pagination
    And hotel "Thien An" has 3 room types
    When I go to the hotel room types page of hotel "Thien An"
    Then I should see 3 room types

  Scenario: list hotel with pagination
    And hotel "Thien An" has 30 room types
    When I go to the hotel room types page of hotel "Thien An"
    Then I should see 25 room types
    And I should see "Next" link
    And I should see "2" link
    When I follow "Next"
    Then I should see 5 room types

  Scenario: see 'New Room Type' link
    When I go to the hotel room types page of hotel "Thien An"
    Then I should see "New Room Type" link
    When I follow "New Room Type"
    Then I should be on the new hotel room type page of hotel "Thien An"
