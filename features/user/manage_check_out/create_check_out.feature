Feature: user creates check out
  In order to operate my hotel
  As a staff member
  I should be able to create check out

  Background:
    Given I am signed in as a staff with username: "trongrg"
    And user "trongrg" is working on hotel "Thien An"
    And hotel "Thien An" has a room type with name: "Deluxe"
    And room type "Deluxe" has a room with number: "101"
    And room "101" has a check in with id: "1", status: "Active"

  Scenario: Create check out
    When I go to the new room check out page of room "101"
    And I create a new check out
    Then I should see a successful create check out message
