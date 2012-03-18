Feature: list furnishings
  In order to manage the furnishings of a room type
  As a hotel owner
  I should be able to list all the furnishings of a room type

  Background:
    Given I am signed in as a hotel owner with username: "trongrg"
    And user "trongrg" has a hotel with name: "Thien An"
    And hotel "Thien An" has a room type with name: "Deluxe"

  Scenario: list furnishings without pagination
    And room type "Deluxe" has 3 furnishings
    When I go to the room type furnishings page of room type "Deluxe"
    Then I should see 3 furnishings

  Scenario: list furnishings with pagination
    And room type "Deluxe" has 30 furnishings
    When I go to the room type furnishings page of room type "Deluxe"
    Then I should see 25 furnishings
    And I should see "Next" link
    And I should see "2" link
    When I follow "Next"
    Then I should see 5 furnishings

  Scenario: do not show furnishings of other room type
    And hotel "Thien An" has a room type with name: "Deluxe 2"
    And room type "Deluxe 2" has 30 furnishings
    And room type "Deluxe" has 10 furnishings
    When I go to the room type furnishings page of room type "Deluxe"
    Then I should see 10 furnishings
