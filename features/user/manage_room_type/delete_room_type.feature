Feature: user delete room type
  In order to manage room types of a hotel
  As a hotel owner
  I should be able to delete new room type

  Background:
    Given I am signed in as a hotel owner
    And I have a hotel with name: "Thien An"
    And hotel "Thien An" has a room type with name: "Deluxe"

  Scenario: Delete from list room types page
    When I go to the hotel room types page of hotel "Thien An"
    And I follow "Delete"
    And I accept the confirm box
    Then I should see a successful delete room type message
    And I should be on the hotel room types page of hotel "Thien An"
