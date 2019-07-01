require 'rails_helper'

describe 'as a vacation owner' do
  describe 'when I visit /owner/vacation/:id' do
    it 'shows an owners vacation info' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      vacation = Vacation.create(name: "Family Reunion", city: "Key West", state: "FL", country: "US", latitude: 24.5551, longitude: 81.7800, start_date: 10.days.from_now, end_date: 15.days.from_now)
      vacation_user_1 = vacation.vacation_users.create!(user_id: user.id, role: 1)
      activity = vacation.activities.create!(price: 40.00, num_attendees: 1, description: "Swim with the fishes", name: "Snorkeling", no_of_days: 1, cutoff_date: "2019-06-12", type: PerPersonCost, user_id: user.id)
      user_1_activity = activity.user_activities.create!(user_id: user.id, quantity: 1, price: 40.00, paid: false)

      visit vacations_path
      click_link "#{vacation.name}"
      expect(current_path).to eq(owner_vacation_path(vacation))

      expect(page).to have_link("+ Invite Participants")
      expect(page).to have_link("+ Add an Activity")
      expect(page).to have_link(activity.name)
    end
  end
end
