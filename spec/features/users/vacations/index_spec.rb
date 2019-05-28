require 'rails_helper'

describe 'as a registered user' do
  describe 'when i visit /dashboard' do
    it 'shows all of my upcoming vacations' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      owner = create(:user)
      vacation = Vacation.create(name: "Family Reunion", location: "Florida", start_date: 10.days.from_now, end_date: 15.days.from_now)
      owner.vacation_users.create(role: 1, vacation: vacation)
      user.vacation_users.create(role: 0, vacation: vacation)

      visit dashboard_path

      within "#vacation-#{vacation.id}" do
        expect(page).to have_link(vacation.name)
        expect(page).to have_content(vacation.start_date.strftime("%m/%d/%Y"))
        expect(page).to have_content(vacation.end_date.strftime("%m/%d/%Y"))
        expect(page).to have_content("Hosted By: #{owner.first_name}")
      end
    end

    it 'shows all past vacations that have an oustanding balance' do
    end
  end
end
