require 'rails_helper'

describe 'as a vacation participant' do
  it 'can participate in a vacation chat' do
    vacation = Vacation.create!(name: "Family Reunion", location: "Hawaii", start_date: "2019-06-12", end_date: "2019-06-15")
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit vacation_messages_path(vacation)

    fill_in 'message_content', with: "hello world"
    click_button "Send"

    visit vacation_messages_path(vacation)
    
    expect(page).to have_content(user.first_name)
    expect(page).to have_content("hello world")
  end
end
