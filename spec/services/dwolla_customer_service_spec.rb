require 'rails_helper'

describe DwollaCustomerService do
  context 'instance methods' do
      it 'posts customer to dwolla' do
        VCR.use_cassette('services/post_customer_to_dwolla') do
          token = $dwolla.auths.client
          user = create(:user)
          user_params = {
            :type => 'personal',
            :address => '7 Sesame Street',
            :city => 'Sesame',
            :state => 'TX',
            :postal_code => '80202',
            :dob => '1970-01-01',
            :ssn => '4444'
          }
          service = DwollaCustomerService.new(user, user_params, token)
          response = service.create_verified_user

          expect(response.response_status).to eq(201)
          expect(response.response_headers[:location]).to include('https://api-sandbox.dwolla.com/customers/')
      end
    end

    it 'sad path 400 response duplicate customer or validation error' do
      VCR.use_cassette('services/failed_post_to_dwolla') do
        token = $dwolla.auths.client
        user = create(:user)
        user_params = {
          :type => 'personal',
          :address => '7 Sesame Street',
          :city => 'Sesame',
          :state => 'TX',
          :postal_code => '80202',
          :dob => '1970-01-01',
          :ssn => '4444'
        }
        service = DwollaCustomerService.new(user, user_params, token)

        response = service.create_verified_user
        begin
          service.create_verified_user
        rescue DwollaV2::Error => e
          expect(e.status).to eq(400)
        end
      end
    end
  end
end
