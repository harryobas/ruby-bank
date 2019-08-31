require 'rails_helper'

RSpec.describe Contexts::UserRegister do

  describe '#call' do
    context "with password" do
      it 'creates a new user' do
        password = 'pa##word'
         result = Contexts::UserRegister.call(password)
        expect(result.keys.count).to eq 3
      end
    end

  end

end
