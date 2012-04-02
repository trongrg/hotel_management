Feature: hotel owner invites staff
  In order to create staff for my hotels,
  As a hotel owner,
  I should be able to invite a staff using his/her email

  Background:
    Given I am signed in as a hotel owner with username: "trongrg"

  Scenario: invite staff
    When I go to the new user invitation page
    And I send an invitation to "test@test.com"
    Then I should see a successful invitation message
    And an invitation email should be sent to "test@test.com"
    And the new user should be a staff
    When I sign out
    And I go to the accept user invitation page with invitation token of user "test@test.com"
    And I update my info
    Then I should see a successful update info message
