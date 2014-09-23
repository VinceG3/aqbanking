require './lib/aqbanking'
include Aqbanking

describe Aqbanking do
  describe '.get_csv' do
    it 'delegates to Gateway' do
      Aqbanking::Gateway.should_receive(:get_csv)
      Aqbanking.get_csv("hi")
    end
  end

  describe '.download_transactions' do
    it 'calls .get_csv' do
      Aqbanking.should_receive(:get_csv) { double('CSV', get_transaction_data: double) }
      Aqbanking.download_transactions("hi")
    end

    it 'calls CSV#get_transaction_data' do
      csv = double
      Aqbanking.stub(:get_csv).and_return(csv)
      csv.should_receive(:get_transaction_data)
      Aqbanking.download_transactions("hi")
    end
  end
end