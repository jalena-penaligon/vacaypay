require "rails_helper"

RSpec.describe Vacation, type: :model do
  describe 'relationships' do
    it { should have_many :activities }
    it { should have_many :vacation_users }
    it { should have_many :messages }
    it { should have_many(:users).through(:vacation_users) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :country }
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date }
  end

  describe 'helper methods' do
    it '.new_vacation returns true when a vacation has no activities' do
      vacation = Vacation.create(name: "Family Reunion", city: "Miami", state: "FL", country: "US", latitude: 25.7617, longitude: 80.1918, start_date: 10.days.from_now, end_date: 15.days.from_now)
      expect(vacation.new_vacation?).to be true

      user = create(:user)
      vacation.activities.create(price: 104.24, num_attendees: 0, name: "Activity", description: "It's an activity", vacation: vacation, user: user, type: FixedCost, cutoff_date: 1.day.from_now)
      expect(vacation.new_vacation?).to be false
    end
  end

  describe 'instance methods' do
    it '.calculate_balance returns cost of unpaid user activities that i do not own' do
      user_1 = create(:user)
      user_2 = create(:user)

      vacation = Vacation.create(name: "Family Reunion", city: "Miami", state: "FL", country: "US", latitude: 25.7617, longitude: 80.1918, start_date: 10.days.from_now, end_date: 15.days.from_now)
      activity_1 = vacation.activities.create!(price: 100.00, num_attendees: 2, name: "Activity 1", description: "It's an activity", vacation: vacation, user: user_1, type: FixedCost, cutoff_date: 100.days.from_now)
      activity_2 = vacation.activities.create!(price: 50.00, num_attendees: 2, name: "Activity 2", description: "It's an activity", vacation: vacation, user: user_2, type: FixedCost, cutoff_date: 100.days.from_now)
      user_activity_1 = user_1.user_activities.create!(quantity: 1, price:100.0, activity: activity_1, paid: true)
      user_activity_2 = user_2.user_activities.create!(quantity: 1, price:100.0, activity: activity_1, paid: false)
      user_activity_3 = user_1.user_activities.create!(quantity: 1, price:50.0, activity: activity_2, paid: false)
      user_activity_4 = user_2.user_activities.create!(quantity: 1, price:50.0, activity: activity_2, paid: true)

      expect(vacation.calculate_balance(user_1)).to eq(50.00)
      expect(vacation.calculate_balance(user_2)).to eq(100.00)
    end

    it '.calculate_owed_balance returns cost of unpaid user activities that i own' do
      user_1 = create(:user)
      user_2 = create(:user)

      vacation = Vacation.create(name: "Family Reunion", city: "Miami", state: "FL", country: "US", latitude: 25.7617, longitude: 80.1918, start_date: 10.days.from_now, end_date: 15.days.from_now)
      activity_1 = vacation.activities.create(price: 100.00, num_attendees: 2, name: "Activity 1", description: "It's an activity", vacation: vacation, user: user_1, type: FixedCost, cutoff_date: 100.days.from_now)
      activity_2 = vacation.activities.create(price: 50.00, num_attendees: 2, name: "Activity 2", description: "It's an activity", vacation: vacation, user: user_2, type: FixedCost, cutoff_date: 100.days.from_now)
      user_activity_1 = user_1.user_activities.create!(quantity: 1, price:100.0, activity: activity_1, paid: true)
      user_activity_2 = user_2.user_activities.create!(quantity: 1, price:100.0, activity: activity_1, paid: false)
      user_activity_3 = user_1.user_activities.create!(quantity: 1, price:50.0, activity: activity_2, paid: true)
      user_activity_4 = user_2.user_activities.create!(quantity: 1, price:50.0, activity: activity_2, paid: false)

      expect(vacation.calculate_owed_balance(user_1)).to eq(100.00)
      expect(vacation.calculate_owed_balance(user_2)).to eq(50.00)
    end

    it '.owner? returns true when the current_user owns that vacation' do
      user = create(:user)
      vacation_1 = Vacation.create(name: "Family Reunion", city: "Miami", state: "FL", country: "US", latitude: 25.7617, longitude: 80.1918, start_date: 10.days.from_now, end_date: 15.days.from_now)
      vacation_2 = Vacation.create(name: "Friends Trip", city: "San Diego", state: "CA", country: "US", latitude: 32.7157, longitude: 117.1611, start_date: 10.days.from_now, end_date: 15.days.from_now)
      vacation_user_1 = user.vacation_users.create(vacation: vacation_1, role: 0)
      vacation_user_2 = user.vacation_users.create(vacation: vacation_2, role: 1)

      expect(vacation_1.owner?(user)).to eq(false)
      expect(vacation_2.owner?(user)).to eq(true)
    end

    it '.host returns the user that hosts a vacation' do
      user = create(:user)
      vacation = Vacation.create(name: "Family Reunion", city: "Key West", state: "FL", country: "US", latitude: 24.5551, longitude: 81.7800, start_date: 10.days.from_now, end_date: 15.days.from_now)
      vacation_user_1 = user.vacation_users.create(vacation: vacation, role: 1)

      expect(vacation.host).to eq(user)
    end
  end
end
