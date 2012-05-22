require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CoopScraper::Account do
  
  context "#coop_date_to_time" do
    subject { CoopScraper::Account.new(nil,nil).send :coop_date_to_time, '22/05/2012' }
    it { should == Time.utc(2012, 5, 22) }
  end
end