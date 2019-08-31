class Contexts::UserCredit
  def self.call(account_id, amount)
    new(account_id, amount).call
  end

  def initialize(acc_id, amt)
    @acc_id = acc_id
    @amt = amt
    @account = Account.find_by!(id: @acc_id)

    assign_creditor(@account)
  end

  def call()
    @creditor.credit_account(@amt)
  end


  private

  def assign_creditor(acc)
    @creditor = Creditor.new(acc)
  end

  class Creditor < SimpleDelegator
    def credit_account(amount)
      self.balance += amount
      if self.save
        create_transaction_record(self, amount)
      end

      return {
        message: "credit successful",
        account: self.id,
        balance: self.balance
      }

    end

    def create_transaction_record(account, amt)
      account.transactions << Transaction.new(timestamp: Time.now, description: "credited with #{amt}")
    end
  end

end
