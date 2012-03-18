Feature: hotel owner create furnishing
  In order to manage furnishings of a room type
  As a hotel owner
  I should be able to create a new furnishing

  Background:
    Given I am signed in as a hotel owner with username: "trongrg"
    And user "trongrg" has a hotel with name: "Thien An"
    And hotel "Thien An" has a room type with name: "Deluxe"

  Scenario: create furnishing
    When I go to the new room type furnishing page of room type "Deluxe"
    And I create a new furnishing
    Then I should see a successful create furnishing message

  Scenario: create furnishing without a name
    When I go to the new room type furnishing page of room type "Deluxe"
    And I create a new furnishing without a name
    Then I should see a missing furnishing's name message

  Scenario: create furnishing without a price
    When I go to the new room type furnishing page of room type "Deluxe"
    And I create a new furnishing without a price
    Then I should see a missing furnishing's price message
