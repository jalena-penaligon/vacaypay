class UserActivity < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :quantity, presence: true, numericality: { greater_than: -1 }

  def user_name
    user = User.find(self.user_id)
    "#{user.first_name} #{user.last_name}"
  end
end
