class AccountHistory

  def self.call(account)
    new(account).call
  rescue StandardError => e
    return {error: e.message}
  end

  def initialize(account)
    @account = Account.find_by!(:id, account)
  rescue ActiveRecord::RecordNotFound => e
    raise StandardError.new "#{account} not found"
  end

  def call
    {transactions: @account.all}
  end 
