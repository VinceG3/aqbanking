require 'active_support/time'

module Aqbanking
  class Gateway
    def self.get_csv(password)
      unless recent_download?
        download_ctx(password) 
        turn_ctx_into_csv
      end
      return CSV.new('./transactions.csv')
    end

    def self.recent_download?(filename = './transactions.csv')
      return false unless File.exist?(filename)
      return true if File.mtime(filename) > 2.hours.ago
      return false
    end

    def self.remove_locks
      `rm -f $HOME/.aqbanking/settings/users/*.lck`
      `rm -f $HOME/.aqbanking/settings/users/*.lck.*`
    end

    def self.download_ctx(password)
      remove_locks
      gem_dir = Gem::Specification.find_by_name('aqbanking').gem_dir
      `#{gem_dir}/script/download_transactions #{password}`
    end

    def self.turn_ctx_into_csv
      `aqbanking-cli listtrans -c transactions.ctx --exporter=csv --profile=full -o transactions.csv`
      File.delete('./transactions.ctx')
    end
  end
end