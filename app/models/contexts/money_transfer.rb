class Contexts::MoneyTransfer
  def self.call(sender, receiver, amount)
    new(sender, receiver, amount).call
  rescue StandardError => e
    return {error: e.message}
  end

  def initialize(sender, receiver, amount)
    @amount = amount
    begin
      @sender = Account.find_by!(id: sender)
    rescue ActiveRecord::RecordNotFound => e
       signal_error(sender)
    end
    begin
      @destination = Account.find_by!(id: receiver)
    rescue ActiveRecord::RecordNotFound => e
      signal_error(receiver)
    end
  
    assign_transferer(@sender)
  end

  def call
    @transferer.transfer_to(@destination, @amount)
  end

  private

  def signal_error(account)
    raise StandardError.new "could not find account #{account}"
  end

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
