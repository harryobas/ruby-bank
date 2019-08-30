class Contexts::MoneyTransfer
  def self.call(sender, receiver, amount)
    new(sender, receiver, amount).call
  rescue ActiveRecord::RecordNotFound => e
    return {error: e.to_s}
  end

  def initialize(sender, receiver, amount)
    @amount = amount
    @sender = Account.find_by!(id: sender)
    @destination = Account.find_by!(id: receiver)

    assign_transferer(@sender)
  end

  def call
    @transferer.transfer_to(@destination, @amount)
  end

  private

  def assign_transferer(account)
    @transferer = Transferer.new(account)
  end

  class Transferer < SimpleDelegator
    def transfer_to(destination, amount)
      self.balance -= amount
      destination.balance += amount
      #create_transaction_entry(self, destination, amount)
      return {
        message: "transfer successful",
        source: self.id,
        destination: destination.id,
        amount: amount
      }
    end

    #def create_transaction_entry(source, destination, amount)
  end


end
