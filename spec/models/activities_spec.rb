require 'rails_helper'

describe Activity do
  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :vacation }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_numericality_of(:price).is_greater_than(0) }
    it { should validate_numericality_of(:num_attendees).is_greater_than(-1) }
  end
end
