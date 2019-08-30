require 'rails_helper'

RSpec.describe Contexts::MoneyTransfer do
  describe '#call' do
    context 'with valid source and destination account' do
      source = User.create(email: 'test@mail.com',
        password: 'pa$$word', account: Account.new).account.id
      destination = User.create(email: 'pepe@mail.com',
        password: 'pa$4444', account: Account.new).account.id
      amount = 10
      result = Contexts::MoneyTransfer.call(source, destination, amount)
      it 'transfers money from source to destination account' do
        expect(result[:source]).to eq source
        expect(result[:destination]).to eq destination
        expect(result[:amount]).to eq amount 
      end
    end
  end
end
