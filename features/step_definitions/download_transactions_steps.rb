Given(/^a valid password and valid ~\/\.aqbanking$/) do
  @password = ENV['BANK_PASSWORD']
end

When(/^I ask for a list of transactions$/) do
  @transactions = Aqbanking.download_transactions(@password)
end

Then(/^I should receive a collection of transaction Hashes$/) do
  @transactions.first.should be_a(Array)
  @transactions.first.first.should be_a(Hash)
end

Given(/^a recently modified transactions\.csv$/) do
  expect(Aqbanking::Gateway).to_not receive(:download_ctx)
  FileUtils.touch('./transactions.csv')
end

Then(/^it should not call out to the external server$/) do
end