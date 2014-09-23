Feature: Download Transactions

	Scenario: Getting a list of transactions
		Given a valid password and valid ~/.aqbanking
		When I ask for a list of transactions
		Then I should receive a collection of transaction Hashes

	Scenario: Getting recent transactions
		Given a valid password and valid ~/.aqbanking
		And a recently modified transactions.csv
		When I ask for a list of transactions
		Then I should receive a collection of transaction Hashes
		And it should not call out to the external server
