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

    it 'allows me to connect with dwolla after registration' do
      VCR.use_cassette('services/get_dwolla_client') do
        user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit root_path

        click_link "Connect to Dwolla"

        fill_in "address", with: "123 Address St."
        fill_in "city", with: "Denver"
        select "CO", :from => "state"
        fill_in "postal_code", with: "80206"
        fill_in "dob", with: "1980-07-11"
        fill_in "ssn", with: "1234"
        click_button "Connect"

        expect(user.dwolla_id).to_not be(nil)
      end
    end
  end
end
