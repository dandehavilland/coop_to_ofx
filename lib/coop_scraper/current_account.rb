require 'coop_scraper/account'

module CoopScraper
  class CurrentAccount < Account
    ID_STRING = "CURRENT ACCOUNT"
    STATEMENT_CLASS = OFX::Statement::CurrentAccount
    
    def determine_trntype details
      case details
      when /^DEBIT INTEREST$/
        :interest
      when /^LINK +[0-9]{2}:[0-9]{2}[A-Z]{3}[0-9]{2}$/
        :atm
      when /^SERVICE CHARGE$/
        :service_charge
      when /^TFR [0-9]{14}$/
        :transfer
      else
        nil
      end
    end
  end
  
end
