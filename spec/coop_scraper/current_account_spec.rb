require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CoopScraper::CurrentAccount do
  before {
    data = read_fixture("statements/current_account.html")
    @account = CoopScraper::CurrentAccount.new(data, Time.now)
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
  
  context "#determine_trntype" do
    context ":interest" do
      subject { @account.send :determine_trntype, "DEBIT INTEREST" }
      it { should == :interest }
    end
    context ":atm" do
      subject { @account.send :determine_trntype, "LINK 18:17OCT23" }
      it { should == :atm }
    end
    context ":service_charge" do
      subject { @account.send :determine_trntype, "SERVICE CHARGE" }
      it { should == :service_charge }
    end
    context ":transfer" do
      subject { @account.send :determine_trntype, "TFR 12345678901234" }
      it { should == :transfer }
    end
  end
end
