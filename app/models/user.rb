class User < ApplicationRecord
  has_one :account

  has_secure_password

end
