Feature: show staff details
  In order to manage my staff
  As a hotel owner,
  I should be able to view staff details

  Background:
    Given I am signed in as a hotel owner with username: "trongrg"
    And user "trongrg" has a hotel with name: "Thien An"
    And a user exists with:
      | username | vannguyen |
      | first name| Van |
      | last name| Nguyen |
      | email | ntvan2104@gmail.com |
      | dob | 21/04/1990 |
      | phone number | 0943189646 |
    And user "vannguyen" is a staff member of hotel "Thien An"


  Scenario: go to show page from list page
    When I go to the hotel staff index page of hotel "Thien An"
    Then I should see 1 staff member
    When I follow "Show"
    Then I should be on the hotel staff page of hotel "Thien An", user "vannguyen"

  Scenario: view details info of staff
    When I go to the hotel staff page of hotel "Thien An", user "vannguyen"
    Then I should see "Username: vannguyen"
    And I should see "Full name: Van Nguyen"
    And I should see "Email: ntvan2104@gmail.com"
    And I should see "Date of birth: April 21, 1990"
    And I should see "Phone number: 0943189646"
    And I should see "Working on: Thien An"
    And I should see "Address:"
