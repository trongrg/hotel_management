@javascript
Feature: user select hotel's location when create/edit hotel
  In order to easily provide my hotel's location
  As a hotel owner
  I should be able to select my hotel location on an embedded google map

  Background:
    Given I am signed in as a hotel owner with username: "trongrg"

  Scenario: select hotel's location when create hotel
    When I go to the new user hotel page of user "trongrg"
    And I click and drag the google map marker to the right
    Then the "Lat" field should have value
    And the "Lng" field should have value

  Scenario: select hotel's location when edit hotel
    And user "trongrg" has a hotel with name: "Thien An"
    When I go to the edit user hotel page of user "trongrg", hotel "Thien An"
    And I click and drag the google map marker to the right
    Then the "Lat" field should have value
    And the "Lng" field should have value
