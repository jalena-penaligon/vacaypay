require 'rails_helper'

describe 'as a vacation owner' do
  it 'can edit an activity I own' do
    #create vacation owner
    user_1 = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    vacation = Vacation.create(name: "Family Reunion", city: "Key West", state: "FL", country: "US", latitude: 24.5551, longitude: 81.7800, start_date: 10.days.from_now, end_date: 15.days.from_now)
    vacation_user_1 = vacation.vacation_users.create!(user: user_1, role: 1)

    #create activity owned by vacation owner
    activity = vacation.activities.create!(price: 40.00, num_attendees: 1, description: "Swim with the fishes", name: "Snorkeling", no_of_days: 1, cutoff_date: "2019-06-12", type: PerPersonCost, user: user_1)
    user_activity = UserActivity.create!(user: user_1, quantity: 1, price: 40.00, paid: true, activity: activity)

    visit vacation_owner_activity_path(vacation, activity)
    click_link "Edit Activity"
    expect(current_path).to eq(edit_vacation_owner_activity_path(vacation, activity))
    expect(find_field('Name').value).to eq("#{activity.name}")
    expect(find_field('Description').value).to eq("#{activity.description}")
    expect(find_field('Price').value).to eq("#{activity.price}")
    expect(find_field('Cutoff date').value).to eq("#{activity.cutoff_date}")
  end
end
