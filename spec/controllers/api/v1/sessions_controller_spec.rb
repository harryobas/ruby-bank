require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  describe 'POST create' do
    context 'with invalid login credentials' do
      it 'it returns error ' do
        post :create, params: {login: {email: "mail@mail.com", password: '########'}}
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['nessage']).to eq 'error' => "mail@mail not found"
      end
    end
  end
end
