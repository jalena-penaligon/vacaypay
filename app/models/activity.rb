class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :vacation
  validates_presence_of :name
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :num_attendees, presence: true, numericality: { greater_than: -1 }
end
