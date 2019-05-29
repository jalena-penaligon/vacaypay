require 'rails_helper'

describe UserActivity do
  describe 'validations' do
    it { should validate_numericality_of(:price).is_greater_than(0) }
    it { should validate_numericality_of(:quantity).is_greater_than(-1) }
  end

  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :activity }
  end

  describe 'instance methods' do
    it 'user_name returns the full name of the user' do
      user = create(:user, first_name: "Cooper", last_name: "Degas")
      vacation = Vacation.create(name: "Tropical Vacay", location: "Bahamas", start_date: 10.days.from_now, end_date: 15.days.from_now)
      activity = vacation.activities.create!(price: 400.00, num_attendees: 2, description: "Sunset catamaran ride.", name: "Catamaran Tour", no_of_days: 1, cutoff_date: "2019-06-12", type: PerPersonCost, user: user)
      user_activity = UserActivity.create!(user: user, quantity: 1, price: 200.00, paid: false, activity: activity)

      expect(user_activity.user_name).to eq("Cooper Degas")
    end
  end
end
