class UserActivity < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :quantity, presence: true, numericality: { greater_than: -1 }
end
