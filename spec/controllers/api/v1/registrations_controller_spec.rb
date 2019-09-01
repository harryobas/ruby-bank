require 'rails_helper'

RSpec.describe Api::V1::RegistrationsController, type: :controller do
  describe 'POST create' do
    context 'with email and password' do
      it 'returns success message' do
        post :create, params: {registration: {email: "example@aol.com", password: "password"}}
        parsed_response = JSON.parse(response.body)
        Rails.logger.debug parsed_response.inspect
        expect(parsed_response['message']).to eq "user created"
      end
    end
    context 'with on email or no password' do
      it 'returns error' do
        post :create, params: {registration: {email: "test@mail.com", password: ""}}, format: :json
        parsed_response = JSON.parse(response.body)

        expect(parsed_response).to eq "error" => "missing data"

      end
    end
  end

end
