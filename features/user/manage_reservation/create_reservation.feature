@javascript @selenium
Feature: user creates reservation
  In order to operate my hotel
  As a staff member
  I should be able to create reservation

  Background:
    Given I am signed in as a staff with username: "trongrg"
    And user "trongrg" is working on hotel "Thien An"
    And hotel "Thien An" has a room type with name: "Deluxe"
    And room type "Deluxe" has a room with number: "101"

  Scenario: Create reservation
    When I go to the new room reservation page of room "101"
    And I create a new reservation
    Then I should see a successful create reservation message
