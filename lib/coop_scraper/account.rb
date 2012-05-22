require 'rubygems'
require 'hpricot'
require 'iconv'

require 'ofx/statement'

module CoopScraper
  class Account
    
    ID_STRING = "ACCOUNT"
    DATE_ID_STRING = "Date"
    ACCT_LENGTH = 8
    STATEMENT_CLASS = OFX::Statement::CurrentAccount
    
    def initialize(html_statement_io, server_response_time)
      @html = prepare_data(html_statement_io)
      @time = server_response_time
    end
    
    def generate_statement
      @doc = Hpricot(@html)
      statement = STATEMENT_CLASS.new
      
      statement.server_response_time = @time
      statement.account_number = account_number
      statement.sort_code = sort_code
      statement.date = statement_date
      statement.ledger_balance = closing_balance
      
      transactions.each { |transaction| statement << transaction }
      
      statement.start_date = statement_start_date
      statement.end_date = statement_date
      statement
    end
    
    protected
    
    def coop_date_to_time(coop_date)
      day, month, year = coop_date.match(/([0-9]{2})\/([0-9]{2})\/([0-9]{4})/).captures
      Time.utc(year, month, day)
    end
    
    def account_number
      @doc.at("h4[text()*='#{self.class::ID_STRING}']").inner_text.match(/([0-9]{#{ACCT_LENGTH}})/)[1]
    end
    
    def sort_code
      @doc.at("h4[text()*='#{self.class::ID_STRING}']").inner_text.match(/([0-9]{2}-[0-9]{2}-[0-9]{2})/)[1].tr('-', '')
    end
    
    def statement_date
      coop_date_to_time(@doc.at("td[text()^='#{self.class::DATE_ID_STRING}']").inner_text)
    end
    
    def transaction_rows
      @transaction_rows ||= begin
        table = @doc.at("th[text()='Transaction']").parent.parent.parent
        table.search('tbody tr')
      end
    end
    
    def transactions
      @transactions ||= begin
        output = []
        a_td = @doc.at('td.transData')
        
        rows = transaction_rows.clone
        rows.shift
        
        transactions = rows.map do |row|
          date    = row.at('td.dataRowL').inner_text
          details = row.at('td.transData').inner_text.strip
          credit  = row.at('td.moneyData:first').inner_text.match(/[0-9.]+/)
          debit   = row.search('td.moneyData')[1].inner_text.match(/[0-9.]+/)
          amount  = credit.nil? ? "-#{debit}" : credit.to_s
          options = {}
          trntype = determine_trntype(details)
          
          options[:trntype] = trntype unless trntype.nil?
          
          OFX::Statement::Transaction.new(amount, coop_date_to_time(date), details, options)
        end
      end
    end
    
    
    def closing_balance
      final_transaction = transaction_rows.last.at('td.moneyData:last').inner_text
      amount = final_transaction.match(/[0-9.]+/).to_s
      sign = final_transaction.match(/[CD]R/).to_s
      sign == "CR" ? amount : "-#{amount}"
    end
    
    def statement_start_date
      coop_date_to_time(
        transaction_rows.first.at('td.dataRowL').inner_text
      )
    end
    
    # ensure no invalid UTF-8 strings are going to fuck with hpricot
    def prepare_data file
      Iconv.new('UTF-8//IGNORE', 'UTF-8').iconv(file.read)
    end
  end
end
