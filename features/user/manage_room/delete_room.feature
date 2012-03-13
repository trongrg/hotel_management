Feature: user delete room
  In order to manage room of a hotel
  As a hotel owner
  I should be able to delete room

  Background:
    Given I am signed in as a hotel owner with username: "trongrg"
    And user "trongrg" has a hotel with name: "Thien An"
    And hotel "Thien An" has a room type with name: "Deluxe"
    And room type "Deluxe" has a room with number: "101"

  Scenario: Delete from list rooms page
    When I go to the hotel rooms page of hotel "Thien An"
    And I follow "Delete"
    And I accept the confirm box
    Then I should see a successful delete room message
    And I should be on the hotel rooms page of hotel "Thien An"

  Scenario: Delete from room page
    When I go to the hotel room page of hotel "Thien An", room "101"
    And I follow "Delete"
    And I accept the confirm box
    Then I should see a successful delete room message
    And I should be on the hotel rooms page of hotel "Thien An"

  Scenario: Delete from edit room page
    When I go to the edit hotel room page of hotel "Thien An", room "101"
    And I follow "Delete"
    And I accept the confirm box
    Then I should see a successful delete room message
    And I should be on the hotel rooms page of hotel "Thien An"
