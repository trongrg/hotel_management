Feature: user delete room type
  In order to manage room types of a hotel
  As a hotel owner
  I should be able to delete new room type

  Background:
    Given I am signed in as a hotel owner with username: "trongrg"
    And user "trongrg" has a hotel with name: "Thien An"
    And hotel "Thien An" has a room type with name: "Deluxe"

  Scenario: Go to edit page from room types page
    When I go to the hotel room types page of hotel "Thien An"
    And I follow "Edit" link of room type "Deluxe"
    Then I should be on the edit hotel room type page of hotel "Thien An", room type "Deluxe"

  Scenario: Edit room type
    When I go to the edit hotel room type page of hotel "Thien An", room type "Deluxe"
    And I edit the room type with valid info
    Then I should see a successful update room type message

  Scenario: Edit room type without name
    When I go to the edit hotel room type page of hotel "Thien An", room type "Deluxe"
    And I edit the room type without a name
    Then I should see a missing room type's name message

  Scenario: Edit room type without price
    When I go to the edit hotel room type page of hotel "Thien An", room type "Deluxe"
    And I edit the room type without a price
    Then I should see a missing room type's price message
