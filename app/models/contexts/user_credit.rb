class Contexts::UserCredit
  def self.call(account_id, amount)
    return {error: "something went wrong"} unless amount.present?
    new(account_id, amount).call
  rescue StandardError => e
    return {error: "#{e.message.to_s}"}
  end

  def initialize(acc_id, amt)
    @acc_id = acc_id
    @amt = amt
    begin
      @account = Account.find_by!(id: @acc_id)
    rescue ActiveRecord::RecordNotFound => e
      signal_error(acc_id)
    end
    assign_creditor(@account)
  end

  def call()
    @creditor.credit_account(@amt)
  end

  private

  def signal_error(acc)
    raise StandardError.new "could not find account #{acc}"
  end

  def assign_creditor(acc)
    @creditor = Creditor.new(acc)
  end

  class Creditor < SimpleDelegator
    def credit_account(amount)
      self.balance += amount
      if self.save
        create_transaction_record_for_credit(self, amount)
      end

      return {
        message: "credit successful",
        account: self.id,
        balance: self.balance
      }
    end

    def create_transaction_record_for_credit(account, amt)
      account.transactions << Transaction.new(timestamp: Time.now, description: "credited with #{amt}")
    end
  end

end
