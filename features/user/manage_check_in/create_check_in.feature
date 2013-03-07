Feature: user creates check in
  In order to operate my hotel
  As a hotel owner
  I should be able to create check in

  Background:
    Given I am signed in as a hotel owner
    And I have a hotel with name: "Thien An"
    And hotel "Thien An" has a room type with name: "Deluxe"
    And room type "Deluxe" has a room with name: "101"

  Scenario: Create check in
    When I go to the new hotel check in page of hotel "Thien An"
    And I create a new check in
    Then I should see a successful create check in message
