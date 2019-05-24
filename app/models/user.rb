class User < ApplicationRecord

  validates :email, uniqueness: true, presence: true
  validates_presence_of :name#, :paypal_token

end
