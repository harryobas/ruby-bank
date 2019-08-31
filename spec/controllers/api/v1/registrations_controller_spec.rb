require 'rails_helper'

RSpec.describe Api::V1::RegistrationsController, type: :controller do
  describe 'POST create' do
    context 'password' do
      it 'registers a new user' do
        post :create, params: {enail: "test@mail.com", password: "password"}
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.keys.count).to eq 3
      end
    end
    context 'no password' do
      it 'returns error' do
        post :create
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to eq "error" => "missing data"

      end
    end
  end

end
