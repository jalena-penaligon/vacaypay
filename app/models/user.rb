class User < ApplicationRecord
  has_many :user_activities
  has_many :activities, through: :user_activities

  validates_uniqueness_of :email
  validates_presence_of :first_name, :last_name
end
