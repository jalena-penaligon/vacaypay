class User < ApplicationRecord
  has_many :user_activities
  has_many :activities, through: :user_activities
  has_many :vacation_users
  has_many :vacations, through: :vacation_users

  validates_uniqueness_of :email
  validates_presence_of :first_name, :last_name, :email
  has_secure_password

  def self.check_for_existing_users(owner, email_array, vacay_id)
    non_existent_users = []
    email_array.each do |email|
      if User.find_by(email: email) == nil
        non_existent_users << email
      else
        self.add_existing_user(owner, email, vacay_id)
      end
    end
    non_existent_users
  end

  def self.add_existing_user(owner, email, vacay_id)
    NotificationMailer.notify(owner, email, vacay_id).deliver_now
    self.update_vacation_user_table(email, vacay_id)
  end

  def self.update_vacation_user_table(email, vacay_id)
    user = User.find_by(email: email)
    VacationUser.create(user_id: user.id, vacation_id: vacay_id)
  end
end
