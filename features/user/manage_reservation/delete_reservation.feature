Feature: delete check in
  In order to manage check in
  As a user,
  I should be able to delete active check in only

  Background:
    Given I am signed in as a hotel owner with username: "trongrg"
    And user "trongrg" has a hotel with name: "Thien An"
    And hotel "Thien An" has a room type with name: "Deluxe"
    And room type "Deluxe" has a room with number: "101"
    And room "101" has a check in with id: "1", status: "Active"

  Scenario: delete active check in
    When I go to the room check ins page of room "101"
    And I follow "Delete" link of check in "1"
    Then I should see a successful delete check in message

  Scenario: delete expired check in
    And room "101" has a check in with id: "2", status: "Expired"
    When I go to the room check ins page of room "101"
    And I follow "Delete" link of check in "2"
    Then I should see "Cannot edit/delete expired check in"
    And I should see 2 check ins
