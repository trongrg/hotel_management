Feature: user list reservations
  In order to manage reservations,
  As a user,
  I should be able to list all/active/expired reservations

  Background:
    Given I am signed in as a hotel owner
    And I have a hotel with name: "Thien An"

  Scenario: list all reservations
    And hotel "Thien An" has 2 reservations
    When I go to the hotel reservations page of hotel "Thien An"
    Then I should see 2 reservations

  Scenario: list reservations with pagination
    And hotel "Thien An" has 27 reservations
    When I go to the hotel reservations page of hotel "Thien An"
    Then I should see 25 reservations
    And I should see "Next" link
    And I should see "2" link
    When I follow "Next"
    Then I should see 2 reservations
