require 'coop_scraper/account'

module CoopScraper
  class CreditCard < Account
    ID_STRING = "CLEARCARD"
    STATEMENT_CLASS = OFX::Statement::CurrentAccount
    ACCT_LENGTH = 16
    
    def sort_code
      nil
    end
    
    def determine_trntype(details)
      case details
      when /^OVERLIMIT CHARGE$/
        :service_charge
      when /^MERCHANDISE INTEREST AT [0-9]+\.[0-9]+% PER MTH$/
        :interest
      else
        nil
      end
    end
  end
end