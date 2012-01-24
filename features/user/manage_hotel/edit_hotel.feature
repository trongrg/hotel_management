Feature: user edits hotel
	As a hotel owner
	In order to manage my hotels
	I should be able to edit my hotel

	Background:
		Given I am signed in as a hotel owner with username: "trongrg"
		And user "trongrg" has a hotel with name: "Thien An"

	Scenario: Go to edit page from hotels page
		When I go to the user hotels page of user "trongrg"
		And I follow "Edit" link of hotel "Thien An"
		Then I should be on the edit user hotel page of user "trongrg", hotel "Thien An"

	Scenario: Edit hotel with valid info
		When I go to the edit user hotel page of user "trongrg", hotel "Thien An"
		And I edit the hotel with valid info
		Then I should see a successful update hotel message

	Scenario: Edit hotel without name
		When I go to the edit user hotel page of user "trongrg", hotel "Thien An"
		And I edit the hotel without a name
		Then I should see a missing hotel's name message

	Scenario: Edit hotel without phone_number
		When I go to the edit user hotel page of user "trongrg", hotel "Thien An"
		And I edit the hotel without a phone number
		Then I should see a missing hotel's phone number message

	Scenario: Edit hotel without lat
		When I go to the edit user hotel page of user "trongrg", hotel "Thien An"
		And I edit the hotel without a lat
		Then I should see a missing hotel's lat message

	Scenario: Edit hotel without lng
		When I go to the edit user hotel page of user "trongrg", hotel "Thien An"
		And I edit the hotel without a lng
		Then I should see a missing hotel's lng message
