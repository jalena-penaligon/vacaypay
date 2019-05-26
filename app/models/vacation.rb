class Vacation < ApplicationRecord
  has_many :activities
  has_many :vacation_users
  has_many :users, through: :vacation_users

  validates_presence_of :name,
                        :location,
                        :start_date,
                        :end_date

  def host
    vacation_user = self.vacation_users.where(role: 1)[0]
    User.find(vacation_user.user_id)
  end

  def new_vacation?
    self.activities.count == 0
  end
end
