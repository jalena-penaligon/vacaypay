class Activity < ApplicationRecord
  belongs_to :vacation
  belongs_to :user
  has_many :user_activities

  validates_presence_of :name
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :num_attendees, presence: true, numericality: { greater_than: -1 }
  validates_presence_of :cutoff_date

  def owner
    User.find(self.user_id)
  end

end
