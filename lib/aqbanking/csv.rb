require 'csv'

module Aqbanking
  class CSV
    attr_reader :csv_file, :csv, :transactions, :struct

    def initialize(csv_file)
      @csv_file = csv_file
    end

    def init_csv
      @csv = ::CSV.new(File.new(@csv_file), col_sep: ';')
    rescue
      raise LoadError.new("Supplied file handle was not a CSV file")
    end

    def parse_csv
      @transactions = []
      make_struct(@csv.shift.collect(&:to_sym))
      @transactions = ugly_ass_parse_hack
    end

    def ugly_ass_parse_hack 
      # This hack is needed because the transaction data
      # as parsed gives no indication which account is which
      # except that the first 250 rows are in my savings and
      # the second 250 are for my checking. Working around
      # with this method. This will probably break on other
      # people's accounts
      first_account = @csv.take(250)
      second_account = @csv.take(250)
      first_output = Array.new
      second_output = Array.new
      first_account.each  {|row| first_output  << @struct.new(*row)} unless @struct.nil?
      second_account.each {|row| second_output << @struct.new(*row)} unless @struct.nil?
      return [first_output, second_output]
    end


    def make_struct(array)
      unless defined?(CSVTransaction)
        Aqbanking.const_set("CSVTransaction", Struct.new("CSVTransaction", *array))
      end
      if @struct.nil?
        @struct = CSVTransaction
      end
    end

    def to_hash_array
      @transactions.collect do |account|
        account.collect do |transaction|
          { 
            description:  transaction.remoteName,
            type:         transaction.transactionText,
            date:         Date.parse(transaction.valutaDate),
            currency:     transaction.value_currency,
            amount:       transaction.value_value.split('/').first.to_i./(100.0),
          }
        end
      end
    end

    def get_transaction_data
      init_csv
      parse_csv
      return to_hash_array
    end
  end
end
