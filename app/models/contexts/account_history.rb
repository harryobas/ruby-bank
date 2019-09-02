class AccountHistory
  def self.call(account_id)
    new(account).call
  rescue StandardError => e
    return {error: e.message}
  end

  def initialize(account_id)
    @account_id = account_id
    @account = Account.find_by!(id: @account_id)
  rescue ActiveRecord::RecordNotFound => e
    raise StandardError.new "#{account_id} not found"

    assign_transactions_reporter(@account)
  end

  def call
    @reporter.report_account_transactions
  end

  private

  def assign_transactions_reporter(account)
    @reporter = TransactionsReporter.new(account)
  end

  class TransactionsReporter < SimpleDelegator

    def report_account_transactions
      transactions = self.transactions.all

      {transactions: transactions}

    end

  end
