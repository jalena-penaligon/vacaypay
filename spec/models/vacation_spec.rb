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
      vacation.activities.create(price: 104.24, num_attendees: 0, name: "Activity", description: "It's an activity", vacation: vacation, user: user, type: 1)
      expect(vacation.new_vacation?).to be false
    end
  end

  describe 'instance methods' do
    it '.calculate_balance returns cost of unpaid user activities that i do not own' do
      user_1 = create(:user)
      user_2 = create(:user)

      vacation = Vacation.create(name: "Family Reunion", location: "Florida", start_date: 100.days.from_now, end_date: 107.days.from_now)
      activity_1 = vacation.activities.create(price: 100.00, num_attendees: 2, name: "Activity 1", description: "It's an activity", vacation: vacation, user: user_1, type: 1)
      activity_2 = vacation.activities.create(price: 50.00, num_attendees: 2, name: "Activity 2", description: "It's an activity", vacation: vacation, user: user_2, type: 1)
      user_activity_1 = user_1.user_activities.create!(quantity: 1, price:100.0, activity: activity_1)
      user_activity_2 = user_2.user_activities.create!(quantity: 1, price:100.0, activity: activity_1)
      user_activity_3 = user_1.user_activities.create!(quantity: 1, price:50.0, activity: activity_2)
      user_activity_4 = user_2.user_activities.create!(quantity: 1, price:50.0, activity: activity_2)

      expect(vacation.calculate_balance(user_1)).to eq(50.00)
      expect(vacation.calculate_balance(user_2)).to eq(100.00)
    end

    it '.calculate_owed_balance returns cost of unpaid user activities that i own' do
      user_1 = create(:user)
      user_2 = create(:user)

      vacation = Vacation.create(name: "Family Reunion", location: "Florida", start_date: 100.days.from_now, end_date: 107.days.from_now)
      activity_1 = vacation.activities.create(price: 100.00, num_attendees: 2, name: "Activity 1", description: "It's an activity", vacation: vacation, user: user_1, type: 1)
      activity_2 = vacation.activities.create(price: 50.00, num_attendees: 2, name: "Activity 2", description: "It's an activity", vacation: vacation, user: user_2, type: 1)
      user_activity_1 = user_1.user_activities.create!(quantity: 1, price:100.0, activity: activity_1)
      user_activity_2 = user_2.user_activities.create!(quantity: 1, price:100.0, activity: activity_1)
      user_activity_3 = user_1.user_activities.create!(quantity: 1, price:50.0, activity: activity_2)
      user_activity_4 = user_2.user_activities.create!(quantity: 1, price:50.0, activity: activity_2)

      expect(vacation.calculate_owed_balance(user_1)).to eq(100.00)
      expect(vacation.calculate_owed_balance(user_2)).to eq(50.00)
    end
  end
end
