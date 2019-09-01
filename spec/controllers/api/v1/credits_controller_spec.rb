require 'rails_helper'

RSpec.describe Api::V1::CreditsController, type: :controller do

  describe 'POST add_credit' do
    it 'returns sucess message' do
      account = User.create(email: "f@mail.com", password: "hello#&&&&", account: Account.new).account.id
      post :add_credit, params: {credit: {account: account, amount: 40.0}}
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['message']).to eq "credit successful"
    end
  end


end
