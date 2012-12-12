@javascript @google_map
Feature: user get hotel's location from its address
  In order to easily provide my hotel's location
  As a hotel owner
  I should be able to get my hotel's location by searching google map

  Scenario: get hotel's location from its address when create hotel
    Given I am signed in
    When I go to the new hotel page
    And I fill in the hotel address
    And I follow "Locate Hotel"
    Then the "Latitude" field should have value
    And the "Longitude" field should have value

  Scenario: get hotel's location from its address when edit hotel
    Given I am signed in as a hotel owner
    And I have a hotel with name: "Thien An"
    When I go to the edit hotel page of hotel "Thien An"
    And I fill in the hotel address
    And I follow "Locate Hotel"
    Then the "Latitude" field should have value
    And the "Longitude" field should have value
