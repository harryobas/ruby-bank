require 'rails_helper'

RSpec.describe Contexts::UserCredit do
  describe '#call' do
    context 'with valid user account' do
      account_id = User.create(email: "test@mail.com",
        password: 'password', account: Account.new).account.id
        balance = Account.find_by(:id => account_id).balance
        amount = 40.0
        result = Contexts::UserCredit.call(account_id, amount)
        it 'adds amount to balance' do
          expect(result[:balance]).to be > balance
        end
    end
  end
end
