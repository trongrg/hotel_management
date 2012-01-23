Feature: hotel owner delete hotel
  As a hotel owner,
  In order to manage my hotels,
  I should be able to delete a hotel

  Background:
    Given I am signed in as a hotel owner with username: "trongrg"
    And user "trongrg" has a hotel with name: "Thien An"

  Scenario: Delete hotel from hotel list
    When I go to the user hotels page of user "trongrg"
    And I follow "Delete" link of hotel "Thien An"
    And I accept the confirm box
    Then I should see a successful delete hotel message

  Scenario: Delete hotel from edit hotel page
    When I go to the edit user hotel page of user "trongrg", hotel "Thien An"
    And I follow "Delete"
    And I accept the confirm box
    Then I should see a successful delete hotel message
    And I should be on the user hotels page of user "trongrg"

  Scenario: Delete hotel from hotel page
    When I go to the user hotel page of user "trongrg", hotel "Thien An"
    And I follow "Delete"
    And I accept the confirm box
    Then I should see a successful delete hotel message
    And I should be on the user hotels page of user "trongrg"
