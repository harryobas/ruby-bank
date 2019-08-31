require 'rails_helper'

RSpec.describe Api::V1::RegistrationsController, type: :controller do
  describe 'POST create' do
    context 'with email and password' do
      it 'returns newly created id' do
        post :create, params: {enail: "test@mail.com", password: "password"}
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.keys.count).to eq 3
      end
    end
  end

end
