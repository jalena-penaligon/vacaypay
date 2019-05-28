require 'rails_helper'

describe 'as a visitor' do
  describe 'when i visit the homepage' do
    it 'can register me as a new user' do
      visit '/'
      click_link "Register"
      expect(current_path).to eq(new_user_path)
      expect(page).to have_content("Create an Account")

      fill_in "user[first_name]", with: "First"
      fill_in "user[last_name]", with: "Last"
      fill_in "user[email]", with: "email@email.com"
      fill_in "user[password]", with: "password"
      fill_in "user[confirm_password]", with: "password"
      click_button "Register"

      user = User.last
      expect(user.first_name).to eq("First")
      expect(user.last_name).to eq("Last")
      expect(user.email).to eq("email@email.com")

      expect(current_path).to eq(dashboard_path)
    end

    it 'can will not allow me to register with an email address that exists' do
      user = User.create(first_name: "First", last_name: "Last", email: "email@email.com", password:"password")
      visit '/'
      click_link "Register"
      expect(current_path).to eq(new_user_path)
      expect(page).to have_content("Create an Account")

      fill_in "user[first_name]", with: "First"
      fill_in "user[last_name]", with: "Last"
      fill_in "user[email]", with: "email@email.com"
      fill_in "user[password]", with: "password"
      fill_in "user[confirm_password]", with: "password"
      click_button "Register"

      expect(page).to have_content("Email has already been taken")
    end

    it 'can will not allow me to register with missing information' do
      visit '/'
      click_link "Register"
      expect(current_path).to eq(new_user_path)
      expect(page).to have_content("Create an Account")

      click_button "Register"

      expect(page).to have_content("First name can't be blank")
      expect(page).to have_content("Last name can't be blank")
      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Password can't be blank")
    end
  end
end
