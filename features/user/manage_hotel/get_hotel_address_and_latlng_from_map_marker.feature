@javascript @google_map
Feature: user get hotel's address and lat lng from google map marker
  In order to easily provide my hotel's address
  As a hotel owner
  I should be able to get my hotel's address from the marker of embedded google map

  Background:
    Given I am signed in as a hotel owner

  Scenario: get hotel's address when create hotel
    When I go to the new hotel page
    And I follow "Get Address"
    Then the "Latitude" field should have value
    And the "Longitude" field should have value
    And the "Line1" field should have value
    And the "Line2" field should have value
    And the "City" field should have value
    And the "State" field should have value

  Scenario: get hotel's address when edit hotel
    And I have a hotel with name: "Thien An"
    When I go to the edit hotel page of hotel "Thien An"
    And I follow "Get Address"
    Then the "Latitude" field should have value
    And the "Longitude" field should have value
    And the "Line1" field should have value
    And the "Line2" field should have value
    And the "City" field should have value
    And the "State" field should have value
