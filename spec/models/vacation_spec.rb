require "rails_helper"

RSpec.describe Vacation, type: :model do
  describe 'relationships' do
    it { should have_many :activities }
    it { should have_many :vacation_users }
    it { should have_many(:users).through(:vacation_users) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :location }
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date }
  end
end
