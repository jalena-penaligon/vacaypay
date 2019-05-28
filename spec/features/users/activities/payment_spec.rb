require 'rails_helper'

describe 'as a registered user who has added a dwolla funding source' do
  describe 'when I visit a vacation show page' do
    it 'can create a payment from a participant to the activity owner' do
      VCR.use_cassette('services/post_dwolla_transfer') do
        user_1 = User.create(first_name: "Jalena", last_name: "Taylor", email: "jalena.marie.taylor@gmail.com", dwolla_id: "f2d9a2a2-d74e-4b52-a3c6-013c0bed5444", dwolla_funding_source: "3916d0d5-5368-45e6-ac63-b2aee3b3f327", password: "password")
        user_2 = User.create(first_name: "Earl", last_name: "Stephens", email: "earl@example.com", dwolla_id: "4e1dead1-19b2-47d0-a386-93253b990231", dwolla_funding_source: "ccd95555-fe25-4ba9-93a5-ac61c0d83e7a", password: "password")
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

        vacation = Vacation.create!(name: "Family Reunion", location: "Hawaii", start_date: "2019-06-12", end_date: "2019-06-15")
        vacation_user_1 = vacation.vacation_users.create!(user_id: user_1.id, role: 1)
        vacation_user_2 = vacation.vacation_users.create!(user_id: user_2.id, role: 0)
        snorkeling = vacation.activities.create!(price: 40.00, num_attendees: 2, description: "Swim with the fishes", name: "Snorkeling", no_of_days: 1, cutoff_date: "2019-06-12", type: 2, user_id: user_2.id)
        user_1_snorkeling = UserActivity.create!(user_id: user_1.id, quantity: 1, price: 40.00, paid: false, activity_id: snorkeling.id)

        visit vacation_path(vacation)

        within "#activity-#{snorkeling.id}" do
          click_button "Settle Up"
          expect(page).to have_content("PAID")
        end

        expect(page).to have_content("You successfully paid for #{snorkeling.name}.")
        expect(page).to have_content("I Owe: $0.00")
      end
    end
  end
end
