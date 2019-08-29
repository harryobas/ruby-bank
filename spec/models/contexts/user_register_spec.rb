require 'rails_helper'

RSpec.describe Contexts::UserRegister do

  describe '#call' do
    context "with email and password" do
      it 'creates a new user' do
        email = 'test@mail.com'
        password = 'pa##word'
        result = Contexts::UserRegister.call(email, password)
        expect(result).to eq({message: 'user created', user: email})
      end
    end
    context 'with no email and password' do
      it 'returns error' do
        result = Contexts::UserRegister.call(nil, nil)
        expect(result).to eq(error: "something went wrong")
      end
    end
    context 'with email and no password' do
      it 'returns error' do
        result = Contexts::UserRegister.call('test@mail.com', nil)
        expect(result).to eq(error: "something went wrong")
      end
    end
    context 'with password and no email' do
      it 'returns error' do
        result = Contexts::UserRegister.call(nil, 'pa##word')
        expect(result).to eq(error: "something went wrong")
      end
    end
    context 'email is blank' do
      it 'returns error' do
        result = Contexts::UserRegister.call("", 'pa##word')
        expect(result).to eq(error: "something went wrong")
      end
    end
  end

end
