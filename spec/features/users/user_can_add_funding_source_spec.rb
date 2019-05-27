require 'rails_helper'

describe 'User' do
  describe 'can add funding source via IAV' do 
    it  'via a link on the user dashboard' do
      VCR.use_cassette('iav/add_funding_source') do 
        user = create(:user)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit dashboard_path(user)
    
        expect(current_path).to eq(dashboard_path(user))
        expect(page).to have_link('Add Your Bank Account')
        expect(user.dwolla_funding_source).to eq(nil)

        click_link 'Add Your Bank Account'

        expect(current_path).to eq(new_users_dwolla_path)
      end
    end 

    it 'can successfully make a new dwolla account' do
      VCR.use_cassette('iav/make_dwolla_acct') do 
        user = create(:user)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit new_users_dwolla_path

        expect(current_path).to eq(new_users_dwolla_path)

        expect(page).to have_content('Connect to Dwolla')

        fill_in :address, with: "Address"
        fill_in :city, with: "City"
        fill_in :state, with: "CO"
        fill_in :postal_code, with: "11111"
        fill_in :dob, with: "1980-01-01"
        fill_in :ssn, with: "1234"
        click_button "Connect"

        expect(current_path).to eq(funding_source_path(user))
      end
    end
  end
end