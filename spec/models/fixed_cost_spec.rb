require 'rails_helper'

describe FixedCost do
  describe 'instance methods' do
    it 'can calculate cost' do
      bachelorette = Vacation.create(name: "Bachelorette", city: "Key West", state: "FL", country: "US", latitude: 24.5551, longitude: 81.7800, start_date: 10.days.from_now, end_date: 15.days.from_now)
      jalena = User.create!(first_name: "Jalena", last_name: "Taylor", email: "jalena.marie.taylor@gmail.com", dwolla_id: "123", dwolla_funding_source: "456", password: "password")

      snorkeling = bachelorette.activities.create!(price: 200.00, num_attendees: 2, description: "Swim with the fishes", name: "Snorkeling", no_of_days: 1, cutoff_date: "2019-06-12", type: FixedCost, user_id: jalena.id)
      price = snorkeling.price_calculation
      expect(price).to eq(100)
    end
  end

end
