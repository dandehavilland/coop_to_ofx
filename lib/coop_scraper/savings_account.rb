require 'coop_scraper/current_account'

module CoopScraper
  class SavingsAccount < CurrentAccount
    ID_STRING = "SAVINGS"
    STATEMENT_CLASS = OFX::Statement::SavingsAccount
  end
end
