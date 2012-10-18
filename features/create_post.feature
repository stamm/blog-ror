Feature: Create new post

	Scenario: Unsuccessfull posting
		Given a user visits the post new page
		When he submits invalid publish post information
		Then he should see an error message

	Scenario: Successfull posting
		Given a user visits the post new page
			And a user submits valid publish post information
		Then he should see a post link on root page

	Scenario: Successfull posting archive
		Given a user visits the post new page
			And a user submits valid arhive post information
		Then he shouldn't see a post link on root page