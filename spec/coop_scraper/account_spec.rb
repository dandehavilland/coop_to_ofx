require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CoopScraper::Account do
  
  before {
    data = read_fixture("statements/account.html")
    @account = CoopScraper::Account.new(data, Time.now)
  }
  subject { @account }
  
  context "#coop_date_to_time" do
    subject { @account.send :coop_date_to_time, 'Date&nbsp;22/05/2012' }
    it { should == Time.utc(2012, 5, 22) }
  end
  
  context "#account_number" do
    subject { @account.send :account_number }
    it { should == "12345678" }
  end
  
  context "#sort_code" do
    subject { @account.send :sort_code }
    it { should == "010203" }
  end
  
  context "#statement_date" do
    subject { @account.send :statement_date }
    it { should == Time.utc(2012,5,11) }
  end
  
  context "#transaction_rows" do
    subject { @account.send :transaction_rows }
    it { should have(6).items }
  end
  
  context "#transactions" do
    subject { @account.send :transactions }
    it { should have(6).items }
  end
  
  context "#closing_balance" do
    subject { @account.send :closing_balance }
    it { should == "11090.00" }
  end
  
  context "#statement_start_date" do
    subject { @account.send :statement_start_date }
    it { should == Time.utc(2012,3,14) }
  end
  
end