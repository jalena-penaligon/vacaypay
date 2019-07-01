require 'rails_helper'

describe 'as an activity owner' do
  describe 'if I update an activity' do
    it 'will update the associated user activities as well' do
      #create vacation owner
      user_1 = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
      vacation = Vacation.create(name: "Family Reunion", city: "Key West", state: "FL", country: "US", latitude: 24.5551, longitude: 81.7800, start_date: 10.days.from_now, end_date: 15.days.from_now)
      vacation_user = VacationUser.create(user: user_1, vacation: vacation, role: 1)

      #create activity owned by vacation owner
      activity = vacation.activities.create!(price: 40.00, num_attendees: 1, description: "Swim with the fishes", name: "Snorkeling", no_of_days: 1, cutoff_date: "2019-06-12", type: PerPersonCost, user: user_1)
      user_activity_1 = UserActivity.create!(user: user_1, quantity: 1, price: 40.00, paid: true, activity: activity)

      #create attending participant
      user_2 = create(:user)
      user_activity_2 = UserActivity.create!(user: user_2, quantity: 1, price: 40.00, paid: true, activity: activity)

      user_3 = create(:user)
      user_activity_3 = UserActivity.create!(user: user_3, quantity: 1, price: 40.00, paid: true, activity: activity)

      visit vacation_owner_activity_path(vacation, activity)
      click_link "Edit Activity"

      fill_in "Price", with: 50.00
      click_button "Update Activity"

      user_activity_1.reload
      user_activity_2.reload
      user_activity_3.reload

      expect(user_activity_1.price.to_f).to eq(50.00)
      expect(user_activity_2.price.to_f).to eq(50.00)
      expect(user_activity_3.price.to_f).to eq(50.00)
    end
  end
end
