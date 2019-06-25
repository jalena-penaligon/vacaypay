class Message < ApplicationRecord
  belongs_to :user
  belongs_to :vacation
  validates :content, presence: true
  scope :for_display, -> { order(:created_at).last(50) }

  def mentions
    content.scan(/@(#{User::NAME_REGEX})/).flatten.map do |username|
      User.find_by(first_name: username)
    end.compact
  end
end
