Feature: user creates hotel
  In order to manage hotels,
  As a hotel owner
  I should be able to create a new hotel

  Background:
    Given I am signed in as a hotel owner

  Scenario: create hotel with valid info
    When I go to the new hotel page
    And I create a new hotel
    Then I should see a successful create hotel message

  Scenario: create hotel without name
    When I go to the new hotel page
    And I create a new hotel without a name
    Then I should see a missing hotel's name message

