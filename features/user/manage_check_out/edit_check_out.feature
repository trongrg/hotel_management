Feature: user edit check outs
  In order to manage check outs,
  As a user,
  I should be able to edit active check out

  Background:
    Given I am signed in as a hotel owner with username: "trongrg"
    And user "trongrg" has a hotel with name: "Thien An"
    And hotel "Thien An" has a room type with name: "Deluxe"
    And room type "Deluxe" has a room with number: "101"
    And room "101" has a check in with id: "1", status: "Active"
    And room "101" has a check out with id: "1"

  Scenario: edit check out
    When I go to the edit room check out page of room "101", check out "1"
    And I edit the check out with valid info
    Then I should see a successful update check out message
