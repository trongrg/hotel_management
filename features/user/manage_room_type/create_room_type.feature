Feature: user creates room type
  In order to manage room types of a hotel
  As a hotel owner
  I should be able to create new room type

  Background:
    Given I am signed in as a hotel owner with username: "trongrg"
    And user "trongrg" has a hotel with name: "Thien An"

  Scenario: create room type
    When I go to the new hotel room type page of hotel "Thien An"
    And I create a new room type
    Then I should see a successful create room type message

  Scenario: create room type without a name
    When I go to the new hotel room type page of hotel "Thien An"
    And I create a new room type without a name
    Then I should see a missing room type's name message
