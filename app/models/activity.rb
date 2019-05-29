class Activity < ApplicationRecord
  belongs_to :vacation
  belongs_to :user
  has_many :user_activities

  validates_presence_of :name
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :num_attendees, presence: true, numericality: { greater_than: -1 }

  # scope :fixed_cost_activity, -> { where(type: FixedCostActivity) }
  # scope :per_person_cost_activity, -> { where(type: PerPersonActivity) }

  def owner
    User.find(self.user_id)
  end

end
