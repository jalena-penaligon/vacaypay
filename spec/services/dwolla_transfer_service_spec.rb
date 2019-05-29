require 'rails_helper'

describe DwollaTransferService do
  describe 'instance methods' do
    it 'posts a successful transfer to dwolla' do
      VCR.use_cassette('services/post_dwolla_transfer') do
        token = $dwolla.auths.client
        source = 'e0a56ffc-26db-4639-955c-68b351b52e9d'
        destination = '59cb098a-872e-4987-868b-4302e1afaaed'

        vacation = Vacation.create!(name: "Family Reunion", location: "Hawaii", start_date: "2019-06-12", end_date: "2019-06-15")
        user_1 = User.create(first_name: "Jalena", last_name: "Taylor", email: "jalena.marie.taylor@gmail.com", dwolla_id: "f2d9a2a2-d74e-4b52-a3c6-013c0bed5444", dwolla_funding_source: "3916d0d5-5368-45e6-ac63-b2aee3b3f327", password: "password")
        user_2 = User.create(first_name: "Earl", last_name: "Stephens", email: "earl@example.com", dwolla_id: "4e1dead1-19b2-47d0-a386-93253b990231", dwolla_funding_source: "ccd95555-fe25-4ba9-93a5-ac61c0d83e7a", password: "password")
        snorkeling = vacation.activities.create!(price: 40.00, num_attendees: 2, description: "Swim with the fishes", name: "Snorkeling", no_of_days: 1, cutoff_date: "2019-06-12", type: PerPersonCost, user_id: user_2.id)
        user_1_snorkeling = UserActivity.create!(user_id: user_1.id, quantity: 1, price: 40.00, paid: false, activity_id: snorkeling.id)

        service = DwollaTransferService.new(source, destination, user_1_snorkeling, token)
        response = service.create_transfer

        expect(response.response_status).to eq(201)

      end
    end
  end
end
