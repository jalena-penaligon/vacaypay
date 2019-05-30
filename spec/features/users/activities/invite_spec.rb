require 'rails_helper'

describe 'as a vacation owner' do
  it 'can invite all vacation participants to an activity' do
    #create vacation owner
    user_1 = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    vacation = Vacation.create(name: "Family Reunion", location: "Florida", start_date: 10.days.from_now, end_date: 15.days.from_now)
    vacation_user_1 = vacation.vacation_users.create!(user: user_1, role: 1)

    #create activity owned by vacation owner
    activity = vacation.activities.create!(price: 40.00, num_attendees: 1, description: "Swim with the fishes", name: "Snorkeling", no_of_days: 1, cutoff_date: "2019-06-12", type: PerPersonCost, user: user_1)
    user_activity = UserActivity.create!(user: user_1, quantity: 1, price: 40.00, paid: true, activity: activity)

    #create vacation participants that are not attending the activity
    user_2 = create(:user)
    user_3 = create(:user)
    vacation_user_2 = vacation.vacation_users.create!(user: user_2, role: 0)
    vacation_user_3 = vacation.vacation_users.create!(user: user_3, role: 0)

    visit owner_vacation_path(vacation)
    click_link "+ Invite All Vacationers"

    activity.reload

    expect(activity.num_attendees).to eq(3)
    expect(current_path).to eq(owner_vacation_path(vacation))
  end
end

describe 'as an activity owner' do
  it 'can invite all participants to an activity' do
    #create vacation owner
    user_1 = create(:user)
    vacation = Vacation.create(name: "Family Reunion", location: "Florida", start_date: 10.days.from_now, end_date: 15.days.from_now)
    vacation_user_1 = vacation.vacation_users.create!(user: user_1, role: 1)

    #create activity owned by a vacation participant
    user_2 = create(:user)
    vacation_user_2 = vacation.vacation_users.create!(user: user_1, role: 0)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_2)

    activity = vacation.activities.create!(price: 40.00, num_attendees: 1, description: "Swim with the fishes", name: "Snorkeling", no_of_days: 1, cutoff_date: "2019-06-12", type: PerPersonCost, user: user_2)
    user_activity = UserActivity.create!(user: user_2, quantity: 1, price: 40.00, paid: true, activity: activity)

    #create vacation participants that are not attending the activity
    user_3 = create(:user)
    vacation_user_3 = vacation.vacation_users.create!(user: user_3, role: 0)

    visit users_vacation_path(vacation)
    
    click_link "+ Invite All Vacationers"

    activity.reload

    expect(activity.num_attendees).to eq(3)
    expect(current_path).to eq(users_vacation_path(vacation))
  end
end
