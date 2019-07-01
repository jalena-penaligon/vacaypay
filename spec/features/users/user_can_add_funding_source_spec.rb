require 'rails_helper'

describe 'A Registered User' do
  describe 'can add funding source via IAV' do
    it 'after successfully making a new dwolla account from the dashboard' do
      VCR.use_cassette('iav/make_dwolla_acct') do
        user = create(:user)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit dashboard_path

        expect(current_path).to eq(dashboard_path)
        expect(user.dwolla_id).to eq(nil)

        expect(page).to have_content('Connect to Dwolla')

        click_link 'Connect to Dwolla'

        fill_in :address, with: "Address"
        fill_in :city, with: "City"
        select "CO", :from => "state"
        fill_in :postal_code, with: "11111"
        fill_in :dob, with: "1980-01-01"
        fill_in :ssn, with: "1234"
        click_button "Connect"

        expect(current_path).to eq(dashboard_path)
        expect(user.dwolla_id).to_not eq(nil)
        expect(user.dwolla_funding_source).to eq(nil)
        expect(page).to have_content('Add My Bank Account')
        expect(page).to_not have_content('Connect To Dwolla')

        click_link "Add My Bank Account"

        expect(current_path).to eq(new_users_funding_source_path)
      end
    end

    it 'can see on dashboard bank account name after connecting account' do
        user = create(:user, dwolla_id: "f2d9a2a2-d74e-4b52-a3c6-013c0bed5444", dwolla_funding_source: "3916d0d5-5368-45e6-ac63-b2aee3b3f327",)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit dashboard_path

        expect(current_path).to eq(dashboard_path)
        expect(page).to_not have_content('Add My Bank Account')
        expect(page).to_not have_content('Connect To Dwolla')
        expect(page).to have_content('Connected Bank Account:')
    end
  end
end
