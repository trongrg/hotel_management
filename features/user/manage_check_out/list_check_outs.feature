Feature: user list check outs
  In order to manage check outs,
  As a user,
  I should be able to list all/active/expired check outs

  Background:
    Given I am signed in as a hotel owner with username: "trongrg"
    And user "trongrg" has a hotel with name: "Thien An"
    And hotel "Thien An" has a room type with name: "Deluxe"
    And room type "Deluxe" has a room with number: "101"
    And room "101" has a check in with status: "Active"
    And room "101" has 5 check outs

  Scenario: list all check outs
    When I go to the room check outs page of room "101"
    Then I should see 5 check outs
