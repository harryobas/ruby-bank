require 'rails_helper'

RSpec.describe Contexts::MoneyTransfer do
  describe '#call' do
    context 'with valid source and destination account' do
      source = User.create(email: 'test@mail.com',
        password: 'pa$$word', account: Account.create).account.id
      destination = User.create(email: 'pepe@mail.com',
        password: 'pa$4444', account: Account.create).account.id
      amount = 10.35
      result = Contexts::MoneyTransfer.call(source, destination, amount)
      it 'transfers money from source to destination account' do
        expect(result[:source]).to eq source
        expect(result[:destination]).to eq destination
        expect(result[:amount]).to eq amount
      end
    end
    context 'with invalid source account' do
      destination = User.create(email: 'pepe@mail.com',
        password: 'pa$4444', account: Account.create).account.id
        amount = 30.3
        result = Contexts::MoneyTransfer.call(700, destination, amount)
        it 'returns error' do
          expect(result).to eq({error: "could not find account #{700.to_s}"})
        end
      end
    end
  end
