require 'ofx/statement/output/base'

module OFX
  module Statement
    module Output
      class SavingsAccount < OFX::Statement::Output::CurrentAccount
        TYPE = "SAVINGS"
      end
    end
  end
end
