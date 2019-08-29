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
      it 'ensures an account is generated for newly created user' do
        usr = User.new({email: "test@mail.com", password: "password"})
        usr_id = "8"
        Contexts::AccountCreate.expects(:call).at_most_once.with(usr_id).returns(usr)
        Contexts::UserRegister.call("test@mail.com", "pa$$word")
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
    context 'password is blank' do
      it 'returns error' do
        result = Contexts::UserRegister.call("test@mail.com", "")
        expect(result).to eq(error: ["Password can't be blank"])
      end
    end
    context 'both email and password blank' do
      it 'returns error' do
        result = Contexts::UserRegister.call("", "")
        expect(result).to eq(error: "something went wrong")
      end
    end

  end

end
