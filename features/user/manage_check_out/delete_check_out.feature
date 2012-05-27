Feature: delete check out
  In order to manage check out
  As a user,
  I should be able to delete active check out only

  Background:
    Given I am signed in as a hotel owner with username: "trongrg"
    And user "trongrg" has a hotel with name: "Thien An"
    And hotel "Thien An" has a room type with name: "Deluxe"
    And room type "Deluxe" has a room with number: "101"
    And room "101" has a check in with id: "1", status: "Active"
    And room "101" has a check out with id: "1"

  Scenario: delete active check out
    When I go to the room check outs page of room "101"
    And I follow "Delete" link of check out "1"
    Then I should see a successful delete check out message
