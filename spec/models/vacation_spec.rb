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

  describe 'helper methods' do
    it '.new_vacation returns true when a vacation has no activities' do
      vacation = Vacation.create(name: "Family Reunion", location: "Florida", start_date: 100.days.from_now, end_date: 107.days.from_now)
      expect(vacation.new_vacation?).to be true

      user = create(:user)
      vacation.activities.create(price: 104.24, num_attendees: 0, name: "Activity", description: "It's an activity", vacation: vacation, user: user, type: FixedCost)
      expect(vacation.new_vacation?).to be false
    end
  end
end
