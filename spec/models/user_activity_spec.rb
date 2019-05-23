require 'rails_helper'

describe UserActivity do
  describe 'validations' do
    it { should validate_inclusion_of(:paid).in_array([true, false])}
    it { should validate_numericality_of(:price).is_greater_than(0) }
    it { should validate_numericality_of(:quantity).is_greater_than(-1) }
  end

  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :activity }
  end
end