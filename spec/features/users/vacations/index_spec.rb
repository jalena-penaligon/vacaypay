require 'rails_helper'

describe 'as a registered user' do
  describe 'when i visit /dashboard' do
    it 'shows all of my upcoming vacations' do
      owner = User.create(name: "Name", email: "owner@email.com", paypal_token: ENV['PAYPAL_TOKEN_KEY'])
      user = User.create(name: "Name", email: "email@email.com", paypal_token: ENV['PAYPAL_TOKEN_KEY'])
      vacation = Vacation.create(name: "Family Reunion", location: "Florida", start_date: 10.days.from_now, end_date: 15.days.from_now)
      owner.vacation_users.create(role: 1, vacation: vacation)
      user.vacation_users.create(role: 0, vacation: vacation)
    end

    it 'shows all past vacations that have an oustanding balance' do
    end
  end
end
