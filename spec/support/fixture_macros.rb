module FixtureMacros
  def fixture_path(fixture_filename)
    File.dirname(__FILE__) + "/../fixtures/#{fixture_filename}"
  end

  def read_fixture(fixture_filename)
    File.read(fixture_path(fixture_filename))
  end
  
  def fixture_doc(name = 'current_account_fixture.html')
    open(fixture_path(name)) { |f| Hpricot(f) }
  end
  
  def normal_transaction_fixture_doc
    fixture_doc('normal_transaction_fixture.html')
  end
  
  def payment_in_transaction_fixture_doc
    fixture_doc('payment_in_transaction_fixture.html')
  end
  
  def no_transactions_fixture_doc
    fixture_doc('no_transactions_fixture.html')
  end
end