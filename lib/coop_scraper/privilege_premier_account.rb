require 'coop_scraper/current_account'

module CoopScraper
  class PrivilegePremierAccount < CurrentAccount
    ID_STRING = "PRIVILEGE PREMIER"
    STATEMENT_CLASS = OFX::Statement::CurrentAccount
  end
end
