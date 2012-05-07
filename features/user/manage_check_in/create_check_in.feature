Feature: user creates check in
  In order to operate my hotel
  As a staff member
  I should be able to create check in

  Background:
    Given I am signed in as a staff with username: "trongrg"
    And user "trongrg" is working on hotel "Thien An"
    And hotel "Thien An" has a room type with name: "Deluxe"
    And room type "Deluxe" has a room with number: "101"

  Scenario: Create check in
    When I go to the new room check in page of room "101"
    And I create a new check in
    Then I should see a successful create check in message
