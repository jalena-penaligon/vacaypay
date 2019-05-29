require 'rails_helper'

describe 'User' do
  describe 'can add funding source via IAV' do 
    it 'after successfully making a new dwolla account from the dashboard' do
      VCR.use_cassette('iav/make_dwolla_acct') do
        user = create(:user)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit dashboard_path

        expect(current_path).to eq(dashboard_path)
        expect(user.dwolla_id).to eq(nil)
        
        expect(page).to have_content('Connect To Dwolla')

        click_link 'Connect To Dwolla'

        fill_in :address, with: "Address"
        fill_in :city, with: "City"
        fill_in :state, with: "CO"
        fill_in :postal_code, with: "11111"
        fill_in :dob, with: "1980-01-01"
        fill_in :ssn, with: "1234"
        click_button "Connect"

        expect(current_path).to eq(dashboard_path)
        expect(user.dwolla_id).to_not eq(nil)
        expect(user.dwolla_funding_source).to eq(nil)
        expect(page).to have_content('Add Your Bank Account')

        click_link "Add Your Bank Account"

        expect(current_path).to eq(new_users_funding_source_path)
      end
    end
  end
end