require "aqbanking/version"
require 'aqbanking/gateway'
require 'aqbanking/csv'

module Aqbanking
  def self.download_transactions(password)
    Aqbanking.get_csv(password).get_transaction_data
  end

  def self.get_csv(password)
    Gateway.get_csv(password)
  end

  class AqbankingError < StandardError
  end
end