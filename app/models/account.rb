class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions

  after_initialize :init

  validates :balance, :numericality => { :greater_than_or_equal_to => 0 }

  def init
    self.balance ||= 0.0
  end

end
