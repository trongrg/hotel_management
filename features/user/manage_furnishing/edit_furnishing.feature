Feature: hotel owner edit furnishing
  In order to manage furnishing of a room type
  As a hotel owner
  I should be able to edit a furnishing

  Background:
    Given I am signed in as a hotel owner with username: "trongrg"
    And user "trongrg" has a hotel with name: "Thien An"
    And hotel "Thien An" has a room type with name: "Deluxe"
    And room type "Deluxe" has a furnishing with name: "Bed"

  Scenario: Edit furnishing
    When I go to the edit room type furnishing page of room type "Deluxe", furnishing "Bed"
    And I edit the furnishing with valid info
    Then I should see a successful update furnishing message

  Scenario: Edit furnishing without a name
    When I go to the edit room type furnishing page of room type "Deluxe", furnishing "Bed"
    And I edit the furnishing without a name
    Then I should see a missing furnishing's name message
