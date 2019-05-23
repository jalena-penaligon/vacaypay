class User < ApplicationRecord
  has_many :user_activities
  has_many :activities, through: :user_activities

  has_one :vacation_user

  validates_uniqueness_of :email
  validates_presence_of :name, :paypal_token
end