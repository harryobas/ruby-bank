class Account < ApplicationRecord
  belongs_to :user

  after_initialize :init

  def init
    self.balance ||= 0.0
  end

end
