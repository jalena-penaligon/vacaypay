require 'rails_helper'

describe 'as a logged in user who is apart of a vacation' do
  it 'can create a new activity' do
    owner = create(:user)
    user = create(:user)
    vacation = Vacation.create(name: "Family Reunion", location: "Florida", start_date: 10.days.from_now, end_date: 15.days.from_now)
    owner.vacation_users.create!(role: 1, vacation: vacation)
    user.vacation_users.create(role: 0, vacation: vacation)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path
    click_link "My Vacations"
    expect(current_path).to eq(vacations_path)
    expect(page).to have_content("Upcoming Vacations")
    click_link('Family Reunion')
    click_link "+ Add an Activity"

    fill_in "activity_name", with: "Activity Test"
    fill_in "activity_description", with: "Sample Description"
    fill_in "activity_price", with: "200"
    fill_in "activity_cutoff_date", with: 100.days.from_now
    fill_in "activity_no_of_days", with: 1
    select "Fixed Cost", :from => "activity_type"
    click_button "Create Activity"
    activity = Activity.last


    expect(current_path).to eq(users_vacation_path(vacation))

    expect(page).to have_content(activity.name)
  end
end
