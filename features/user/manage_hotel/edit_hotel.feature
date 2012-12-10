Feature: user edits hotel
  As a hotel owner
  In order to manage my hotels
  I should be able to edit my hotel

  Background:
    Given I am signed in as a hotel owner with email: "trongrg@gmail.com"
    And user "trongrg@gmail.com" has a hotel with name: "Thien An"

  Scenario: Go to edit page from hotels page
    When I go to the hotels page
    And I follow "Edit" link of hotel "Thien An"
    Then I should be on the edit hotel page of hotel "Thien An"

  Scenario: Edit hotel with valid info
    When I go to the edit hotel page of hotel "Thien An"
    And I edit the hotel with valid info
    Then I should see a successful update hotel message

  Scenario: Edit hotel without name
    When I go to the edit hotel page of hotel "Thien An"
    And I edit the hotel without a name
    Then I should see a missing hotel's name message

  Scenario: Edit hotel without phone
    When I go to the edit hotel page of hotel "Thien An"
    And I edit the hotel without a phone
    Then I should see a missing hotel's phone message

  Scenario: Edit hotel without location
    When I go to the edit hotel page of hotel "Thien An"
    And I edit the hotel without a location
    Then I should see a missing hotel's location attributes latitude message

  @javascript @wip
  Scenario: See my hotel location on embedded google map
    When I go to the edit hotel page of hotel "Thien An"
    Then I should see the google map marker points to my hotel's location
