require 'rails_helper'

RSpec.describe Contexts::UserRegister do

  describe '#call' do
    context "with password snd email" do
      it 'creates a new user' do
        password = 'pa##word'
        email = 'test@mail.com'
         result = Contexts::UserRegister.call(email, password)
        expect(result.keys.count).to eq 3
      end
    end

  end

end
