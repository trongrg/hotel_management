Feature: user list staff of a hotel
  In order ot manage staff of a hotel,
  As a hotel owner,
  I should be able to list all staff of my hotel

  Background:
    Given I am signed in as a hotel owner with username: "trongrg"
    And user "trongrg" has a hotel with name: "Thien An"
    And hotel "Thien An" has 5 staff members

  Scenario: list staff
    When I go to the hotel staff index page of hotel "Thien An"
    Then I should see 5 staff members

  Scenario: brief info of staff
    When I go to the hotel staff index page of hotel "Thien An"
    Then I should see staff brief info
    And I should see actions Show, Remove
