@javascript
Feature: user get hotel's address and lat lng from google map marker
  In order to easily provide my hotel's address
  As a hotel owner
  I should be able to get my hotel's address from the marker of embedded google map

  Background:
    Given I am signed in as a hotel owner with username: "trongrg"

  Scenario: get hotel's address when create hotel
    When I go to the new hotel page
    And I follow "Get Address"
    Then the "Lat" field should have value
    And the "Lng" field should have value
    And the "Address1" field should have value
    And the "Address2" field should have value
    And the "City" field should have value
    And the "State" field should have value

  Scenario: get hotel's address when edit hotel
    And user "trongrg" has a hotel with name: "Thien An"
    When I go to the edit hotel page of hotel "Thien An"
    And I follow "Get Address"
    Then the "Lat" field should have value
    And the "Lng" field should have value
    And the "Address1" field should have value
    And the "Address2" field should have value
    And the "City" field should have value
    And the "State" field should have value
