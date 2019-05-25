require 'rails_helper'

describe 'as a visitor' do
  describe 'when I visit the homepage' do
    it 'shows links appropriate for a logged out user' do
      visit '/'

      expect(page).to have_link("Register")
      expect(page).to have_link("Log In")
    end
  end
end

describe 'as a logged in user' do
  describe 'when I visit any page' do
    it 'shows links appropriate for a logged in user' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit '/'

      expect(page).to have_link("+ Create a Vacation")

      expect(page).to have_link("Log Out")
      expect(page).to have_content("Logged in as #{user.first_name}")
    end
  end
end
