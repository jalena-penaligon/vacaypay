require 'rails_helper'

describe 'as a registered user' do
  describe 'who has been invited to a vacation' do
    it 'shows all of the activities that I am attending' do
      user = User.create(name: "Participant Name", email: "email@email.com", paypal_token: ENV['PAYPAL_TOKEN_KEY'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      owner = User.create(name: "Owner Name", email: "owner@email.com", paypal_token: ENV['PAYPAL_TOKEN_KEY'])
      vacation = Vacation.create(name: "Family Reunion", location: "Florida", start_date: 10.days.from_now, end_date: 15.days.from_now)
      owner.vacation_users.create(role: 1, vacation: vacation)
      user.vacation_users.create(role: 0, vacation: vacation)
      activity = Activity.create(name: "Kayaking", price: 20.0, num_attendees: 1, description: "It'll be fun.", date: 12.days.from_now, vacation: vacation, user: owner)
      user_activity = user.user_activities.create!(quantity: 1, price:20.0, activity: activity)

      visit dashboard_path
      click_link(vacation.name)
      save_and_open_page
      expect(current_path).to eq(vacation_path(vacation))
      expect(page).to have_content(vacation.name)
      within "#activity-#{activity.id}" do
        expect(page).to have_content(activity.name)
        expect(page).to have_content(activity.price)
        expect(page).to have_button("Settle Up")
      end
    end
  end
end
