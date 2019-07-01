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

  describe 'instance methods' do
    it '.owner returns the user that owns an activity' do
      user_1 = create(:user)
      user_2 = create(:user)
      vacation = Vacation.create(name: "Family Reunion", city: "Key West", state: "FL", country: "US", latitude: 24.5551, longitude: 81.7800, start_date: 10.days.from_now, end_date: 15.days.from_now)
      activity = vacation.activities.create!(price: 40.00, num_attendees: 2, description: "Swim with the fishes", name: "Snorkeling", no_of_days: 1, cutoff_date: "2019-06-12", type: PerPersonCost, user: user_1)
      user_1_snorkeling = UserActivity.create!(user: user_1, quantity: 1, price: 40.00, paid: true, activity: activity)
      user_2_snorkeling = UserActivity.create!(user: user_2, quantity: 1, price: 40.00, paid: false, activity: activity)

      expect(activity.owner).to eq(user_1)
    end
  end
end
