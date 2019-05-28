require 'rails_helper'

describe PerPersonCost do
  describe 'instance methods' do
    it 'can calculate cost' do
      bachelorette = Vacation.create!(name: "bachelorette", location: "Hawaii", start_date: "2019-06-12", end_date: "2019-06-15")
      jalena = User.create!(first_name: "Jalena", last_name: "Taylor", email: "jalena.marie.taylor@gmail.com", dwolla_id: "123", dwolla_funding_source: "456", password: "password")

      snorkeling = bachelorette.activities.create!(price: 200.00, num_attendees: 2, description: "Swim with the fishes", name: "Snorkeling", no_of_days: 1, cutoff_date: "2019-06-12", type: PerPersonCost, user_id: jalena.id)
      price = snorkeling.price_calculation
      expect(price).to eq(200)
    end
  end

end
