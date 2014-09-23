require 'spec_helper'
include Aqbanking


describe Aqbanking do
  before(:each) do
    Aqbanking.send(:remove_const, :CSVTransaction) if defined?(CSVTransaction)
    Struct.send(:remove_const, :CSVTransaction) if defined?(Struct::CSVTransaction)
  end

  describe CSV do
    describe '#initialize' do
      it 'saves a csv file' do
        csv = Aqbanking::CSV.new('hi')
        expect(csv.csv_file).to eq('hi')
      end
    end

    describe '#init_csv' do
      it 'opens the file with CSV' do
        csv = Aqbanking::CSV.new('spec/test_transactions.csv')
        csv.init_csv
        expect(csv.csv).to be_a(CSV)
      end

      it "raises an error if it's not a CSV file" do
        expect do
          csv = Aqbanking::CSV.new('Supplies!!')
          csv.init_csv
        end.to raise_error(LoadError)
      end
    end

    describe '#parse_csv' do
      subject { Aqbanking::CSV.new('spec/test_transactions.csv') }

      it "calls #make_struct" do
        subject.should_receive(:make_struct)
        subject.init_csv
        subject.parse_csv
      end

      it "reads the transactions into structs" do
        subject.init_csv
        subject.parse_csv
        expect(subject.transactions).to be_a(Array)
        expect(subject.transactions.first).to be_a(Array)
        expect(subject.transactions[1]).to be_a(Array)
        expect(subject.transactions.first.collect(&:class).uniq.first).to be(CSVTransaction)
      end
    end

    describe '#make_struct' do
      it "makes a Struct from the headers of the CSV file" do
        headers = [:arg1, :arg2, :arg3]
        csv = Aqbanking::CSV.new('hi')
        csv.make_struct(headers)
        expect(csv.struct).to be_a(Class)
        expect do
          CSVTransaction
        end.to_not raise_error
      end

      it "does not redefine CSVTransaction if it is already defined" do
        Aqbanking.const_set("CSVTransaction", Class.new)
        expect(Aqbanking).to_not receive(:const_set)
        Aqbanking::CSV.new('./transactions.csv').make_struct([])
      end

      it "sets @struct if it is nil" do
        Aqbanking.const_set("CSVTransaction", Class.new)
        csv = Aqbanking::CSV.new('./transactions.csv')
        csv.make_struct([])
        expect(csv.struct).to_not be_nil
      end

      it "does not redefine @struct if it is already set" do
        Aqbanking.const_set("CSVTransaction", Class.new)
        csv = Aqbanking::CSV.new('./transactions.csv')
        binding.pry
        csv.make_struct([])
        
      end
    end

    describe '#to_hash_array' do
      subject do
        csv = Aqbanking::CSV.new('spec/test_transactions.csv')
        csv.init_csv
        csv.parse_csv
        hash_array = csv.to_hash_array.first
      end

      # hacked, the transactions are in two arrays, each
      # array represents a different account.

      it "takes the transactions and returns the relevant fields in hash form" do
        expect(subject).to be_a(Array)
        expect(subject.collect(&:class).uniq.first).to be(Hash)
      end

      it "has the right keys in the hashes" do
        [:description, :type, :date, :currency, :amount].each do |key|
          expect(subject.first[key]).to_not be_nil, "expected but didn't find :#{key}"
        end
      end
    end

    describe '#get_transaction_data' do
      subject { Aqbanking::CSV.new('spec/test_transactions.csv') }
      it "goes through all the steps" do
        [:init_csv, :parse_csv, :to_hash_array].each do |msg|
          subject.should_receive(msg)
        end
        subject.get_transaction_data
      end

      it "has the right data" do
        expect(subject.get_transaction_data.first.first).to eq({:description=>"Interest Earned", :type=>"Generic credit", :date=>Date.parse('2014-07-23'), :currency=>"USD", :amount=>0.06})
      end
    end
  end
end