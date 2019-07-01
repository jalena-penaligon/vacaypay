require 'rails_helper'

describe 'as a vacation participant' do
  it 'can participate in a vacation chat' do
    vacation = Vacation.create(name: "Family Reunion", city: "Key West", state: "FL", country: "US", latitude: 24.5551, longitude: 81.7800, start_date: 10.days.from_now, end_date: 15.days.from_now)
    user = create(:user)
    vacation_user = VacationUser.create(user: user, vacation: vacation, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit vacation_messages_path(vacation)

    fill_in 'message_content', with: "hello world"
    click_button "Send"

    visit vacation_messages_path(vacation)
    expect(page).to have_content(user.first_name)
    expect(page).to have_content("hello world")
  end
end
