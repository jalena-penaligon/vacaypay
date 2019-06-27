class Vacation < ApplicationRecord
  has_many :activities
  has_many :vacation_users
  has_many :users, through: :vacation_users
  has_many :messages

  validates_presence_of :name,
                        # :location,
                        :start_date,
                        :end_date

  def host
    vacation_user = self.vacation_users.where(role: 1)[0]
    User.find(vacation_user.user_id)
  end

  def new_vacation?
    self.activities.count == 0
  end

  def calculate_balance(user)
    find_activities(user).where(user_id: user.id).where.not('activities.user_id' => user.id).sum(:price)
  end

  def find_activities(user)
    UserActivity
    .joins(:activity)
    .where(paid: false)
    .where('activities.vacation_id' => self.id)
  end

  def calculate_owed_balance(user)
    find_activities(user).where('activities.user_id' => user.id).sum(:price)
  end

  def owner?(user)
    self.vacation_users.any? do |vu|
      vu.user_id == user.id && vu.vacation_id == self.id && vu.role == 1
    end
  end
end
