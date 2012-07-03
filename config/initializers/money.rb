require 'money'
require 'money/bank/google_currency'
# monkey patch to allow Money object to be used in nested form
class Money
  def persisted?
    true
  end
  def id
    1
  end
end
# exchange rate by goole currency
Money.default_bank = Money::Bank::GoogleCurrency.new
# patch for vnd
Money::Currency::table[:vnd][:symbol_first] = false
