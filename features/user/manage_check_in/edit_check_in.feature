Feature: user edit check ins
  In order to manage check ins,
  As a user,
  I should be able to edit active check in

  Background:
    Given I am signed in as a hotel owner
    And I have a hotel with name: "Thien An"
    And hotel "Thien An" has a room type with name: "Deluxe"
    And room type "Deluxe" has a room with name: "101"
    And hotel "Thien An" has a check in with id: "1", status: "Active"

  Scenario: edit check in
    When I go to the edit hotel check in page of hotel "Thien An", check in "1"
    And I edit the check in with valid info
    Then I should see a successful update check in message
