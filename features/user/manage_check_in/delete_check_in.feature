Feature: delete check in
  In order to manage check in
  As a user,
  I should be able to delete active check in only

  Background:
    Given I am signed in as a hotel owner
    And I have a hotel with name: "Thien An"
    And hotel "Thien An" has a check in with status: "Active"

  Scenario: delete active check in
    When I go to the hotel check ins page of hotel "Thien An"
    And I follow "Delete"
    Then I should see a successful delete check in message
