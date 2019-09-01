require 'rails_helper'

RSpec.describe Api::V1::TransfersController, type: :controller do
  describe 'POST transfer_funds' do

    context "with sufficient funds" do
      sender = User.create(email: "f@mail.com", password: "hello#&&&&", account: Account.new({balance: 40.0}))
        destination =  User.create(email: "text@aol.com", password: "password", account: Account.new)
        amount = 20.0
      it 'returns success message ' do
        post :transfer_funds, params: {transfer: {sender: sender.account.id, destination: destination.account.id,
          amount: amount}}
          parsed_response = JSON.parse (response.body)
          expect(parsed_response['message']).to eq "transfer successful"
      end
    end
    context 'with insufficient funds' do
      source = User.create(email: "frankie@aol.com", password: "hello222", account: Account.new({balance: 50.0}))
      destination =  User.create(email: "text@aol.com", password: "password", account: Account.new)
      amt = 100.0
      it 'returns error message' do
        post :transfer_funds, params: {transfer: {sender: source.account.id, destination: destination.account.id,
          amount: amt}}
          parsed_response = JSON.parse (response.body)
          expect(parsed_response['error']).to eq "insufficient funds"
      end
    end
  end

end
