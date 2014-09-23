require 'spec_helper'
include Aqbanking

describe Gateway do
  let(:test_csv) { './spec/test_transactions.csv' }
  describe '.recent_download?' do
    it "returns false if given a non-existent filename" do
      expect(Gateway.recent_download?('Supplies!!!')).to be_false
    end

    it "returns false if the file given has a long-ago access time" do
      File.utime(1.year.ago, 1.year.ago, test_csv)
      expect(Gateway.recent_download?(test_csv)).to be_false
    end

    it "returns true if the file given was modified recently" do
      FileUtils.touch(test_csv)
      expect(Gateway.recent_download?(test_csv)).to be_true
    end
  end
end