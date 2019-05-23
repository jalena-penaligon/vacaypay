class Vacation < ApplicationRecord

  has_many :activities
  has_many :vacation_users
  has_many :users, through: :vacation_users

  validates_presence_of :name,
                        :location,
                        :start_date,
                        :end_date

end
