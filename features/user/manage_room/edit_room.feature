Feature: user edit room
  In order to manage room of a hotel
  As a hotel owner
  I should be able to edit a room

  Background:
    Given I am signed in as a hotel owner
    And I have a hotel with name: "Thien An"
    And hotel "Thien An" has a room type with name: "Deluxe"
    And room type "Deluxe" has a room with name: "101"

  Scenario: Edit room
    When I go to the edit hotel room page of hotel "Thien An", room "101"
    And I edit the room with valid info
    Then I should see a successful update room message

  Scenario: Edit room without number
    When I go to the edit hotel room page of hotel "Thien An", room "101"
    And I edit the room without a name
    Then I should see a missing room's name message

  Scenario: Edit room without room type
    When I go to the edit hotel room page of hotel "Thien An", room "101"
    And I edit the room without a room type
    Then I should see a missing room's room type message
