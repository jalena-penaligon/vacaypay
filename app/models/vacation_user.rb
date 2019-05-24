class VacationUser < ApplicationRecord
  belongs_to :vacation, foreign_key: 'vacation_id'
  belongs_to :user, foreign_key: 'user_id'
  validates_presence_of :role
end
