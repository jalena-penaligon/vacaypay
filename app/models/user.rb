class User < ApplicationRecord
  has_many :user_activities
  has_many :activities, through: :user_activities
  has_many :vacation_users
  has_many :vacations, through: :vacation_users

  validates_uniqueness_of :email
  validates_presence_of :first_name, :last_name
  has_secure_password
end
