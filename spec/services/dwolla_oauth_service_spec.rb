require 'rails_helper'

describe DwollaOauthService do
  context 'instance methods' do
    it 'retrieves DwollaClient' do
      VCR.use_cassette('services/get_dwolla_client') do
        token = $dwolla.auths.client
        expect(token).to be_a(DwollaV2::Token)
      end
    end
  end
end
