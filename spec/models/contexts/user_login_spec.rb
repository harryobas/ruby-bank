require 'rails_helper'

RSpec.describe Contexts::UserLogin do

  describe '#call' do
    context 'with correct email and password' do
      user = User.create(:email => "harry@aol.com", :password => '#####')
      result = Contexts::UserLogin.call(user.email, user.password)
      data_attr = [:jwt, :user]
      it 'returns a jwt token' do
        expect(result.keys).to eq(data_attr)
      end
    end
    context 'with incorrect email and correct password' do
      user = User.create(:email => "harry@aol.com", :password => '#####')
      result = Contexts::UserLogin.call('peter@mail.com', user.password)
      it 'returns error' do
        expect(result).to eq({error: "peter@mail.com not found"})
      end
    end
    

  end
end
