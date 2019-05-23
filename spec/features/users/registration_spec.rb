require 'rails_helper'

describe 'as a visitor' do
  describe 'when I visit the homepage and click on register' do
    it 'creates my account through paypal' do
      visit root_path
      expect(page).to have_link("Register")
      expect(page).to have_link("Log In")

      click_link("Register")

      user = User.last
      user.update_column(:paypal_token, ENV["PAYPAL_TOKEN_KEY"])

      visit root_path
      expect(page).to_not have_content("Register")
      expect(page).to_not have_content("Log In")
    end
  end
end
