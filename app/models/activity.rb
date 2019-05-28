class Activity < ApplicationRecord
  belongs_to :vacation
  belongs_to :user
  has_many :user_activities

  validates_presence_of :name
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :num_attendees, presence: true, numericality: { greater_than: -1 }

  self.inheritance_column = :activity_type
  scope :fixed_cost, -> { where(activity_type: '1') }
  scope :per_person_cost, -> { where(activity_type: '2') }
end
