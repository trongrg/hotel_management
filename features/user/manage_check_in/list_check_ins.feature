Feature: user list check ins
  In order to manage check ins,
  As a user,
  I should be able to list all/active/expired check ins

  Background:
    Given I am signed in as a hotel owner
    And I have a hotel with name: "Thien An"
    And hotel "Thien An" has a check in with status: "Active"
    And hotel "Thien An" has a check in with status: "Expired"

  Scenario: list all check ins
    When I go to the hotel check ins page of hotel "Thien An"
    Then I should see 2 check ins

  Scenario: list all expired check ins
    When I go to the hotel check ins page of hotel "Thien An", status "expired"
    Then I should see 1 check ins

  Scenario: list all active check ins
    When I go to the hotel check ins page of hotel "Thien An", status "active"
    Then I should see 1 check ins

  Scenario: list check ins with pagination
    And hotel "Thien An" has 30 check ins
    When I go to the hotel check ins page of hotel "Thien An"
    Then I should see 25 check ins
    And I should see "Next" link
    And I should see "2" link
    When I follow "Next"
    Then I should see 7 check ins
