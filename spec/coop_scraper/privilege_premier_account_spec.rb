require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CoopScraper::PrivilegePremierAccount do
  before {
    data = read_fixture("statements/privilege_premier_account.html")
    @account = CoopScraper::PrivilegePremierAccount.new(data, Time.now)
  }
  subject { @account }

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
end
