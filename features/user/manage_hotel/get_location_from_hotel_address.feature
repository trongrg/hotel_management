@javascript
Feature: user get hotel's location from its address
  In order to easily provide my hotel's location
  As a hotel owner
  I should be able to get my hotel's location by searching google map

  Background:
    Given I am signed in as a hotel owner with username: "trongrg"

  Scenario: get hotel's location from its address when create hotel
    When I go to the new hotel page
    And I fill in the hotel address
    And I follow "Search on Google Map"
    Then the "Lat" field should have value
    And the "Lng" field should have value

  Scenario: get hotel's location from its address when edit hotel
    And user "trongrg" has a hotel with name: "Thien An"
    When I go to the edit hotel page of hotel "Thien An"
    And I fill in the hotel address
    And I follow "Search on Google Map"
    Then the "Lat" field should have value
    And the "Lng" field should have value
