@javascript
Feature: hotel owner create hotel asynchronously from hotels list page
  As a hotel owner,
  In order to create hotel easily,
  I should be able to create hotel from an ajax from on hotels list page

  Background:
    Given I am signed in as a hotel owner with email: "trongrg@gmail.com"
    Given I am on the hotels page

  Scenario: create hotel with invalid info
    When I follow "Create Hotel"
    Then I should see a create hotel popup dialog
    When I create a new hotel without a name
    Then I should see a missing hotel's name message
    When I create a new hotel without a latitude
    Then I should see a missing hotel's location attributes latitude message
    When I create a new hotel without a longitude
    Then I should see a missing hotel's location attributes longitude message
    When I create a new hotel without a phone
    Then I should see a missing hotel's phone message
    # When I create a new hotel with an invalid phone
    # Then I should see a invalid hotel's phone message

  Scenario: create hotel with valid info
    When I follow "Create Hotel"
    Then I should see a create hotel popup dialog
    When I create a new hotel
    Then I should not see the create hotel popup dialog
    But I should see a successful create hotel message
    And I should see the newly created hotel

