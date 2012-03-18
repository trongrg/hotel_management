Feature: hotel owner delete furnishing
  In order to manage furnishings of a room type
  As a hotel owner
  I should be able to delete furnishing

  Background:
    Given I am signed in as a hotel owner with username: "trongrg"
    And user "trongrg" has a hotel with name: "Thien An"
    And hotel "Thien An" has a room type with name: "Deluxe"
    And room type "Deluxe" has a furnishing with name: "Bed"

  Scenario: Delete from list furnishings page
    When I go to the room type furnishings page of room type "Deluxe"
    And I follow "Delete"
    And I accept the confirm box
    Then I should see a successful delete furnishing message
    And I should be on the room type furnishings page of room type "Deluxe"

  Scenario: Delete from furnising page
    When I go to the room type furnishing page of room type "Deluxe", furnishing "Bed"
    And I follow "Delete"
    And I accept the confirm box
    Then I should see a successful delete furnishing message
    And I should be on the room type furnishings page of room type "Deluxe"

  Scenario: Delete from edit furnishing page
    When I go to the edit room type furnishing page of room type "Deluxe", furnishing "Bed"
    And I follow "Delete"
    And I accept the confirm box
    Then I should see a successful delete furnishing message
    And I should be on the room type furnishings page of room type "Deluxe"
