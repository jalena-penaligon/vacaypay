#users
jalena = User.create!(first_name: "Jalena", last_name: "Taylor", email: "jalena.marie.taylor@gmail.com", dwolla_id: "f2d9a2a2-d74e-4b52-a3c6-013c0bed5444", dwolla_funding_source: "3916d0d5-5368-45e6-ac63-b2aee3b3f327", password: "password")
earl = User.create!(first_name: "Earl", last_name: "Stephens", email: "earl@example.com", dwolla_id: "4e1dead1-19b2-47d0-a386-93253b990231", dwolla_funding_source: "ccd95555-fe25-4ba9-93a5-ac61c0d83e7a", password: "password")
ethan = User.create!(first_name: "Ethan", last_name: "Grab", email: "ethan@example.com", dwolla_id: "d821344a-06be-4749-80ec-1a49932a3906", dwolla_funding_source: "e0a56ffc-26db-4639-955c-68b351b52e9d", password: "password")
chi = User.create!(first_name: "Chi", last_name: "Tran", email: "chi@example.com", dwolla_id: "2cfe939f-b607-4f86-9847-6b887e2aa817", dwolla_funding_source: "a4480983-07cc-4ab7-87c6-1f2465c5e3f3", password: "password")
belle = User.create!(first_name: "Belle", last_name: "Matisse", email: "vincenzokuphal@corkeryschneider.biz", dwolla_id: "5fbbacb7-5ec7-4ded-be1a-40aabec831ab", dwolla_funding_source: nil, password: "password")
lexi = User.create!(first_name: "Lexi", last_name: "Degas", email: "lexi@lexi.com", dwolla_id: "38a489d4-75d8-4885-b3d9-007767b0d29e", dwolla_funding_source: "c69f6648-7260-46b2-a61e-4052b5c6d877", password: "password")
bear = User.create!(first_name: "Bear", last_name: "Caravaggio", email: "bear@email.com", dwolla_id: "77b071f3-7a00-4bd7-b015-8a80852c87e8", dwolla_funding_source: "62ecefbf-a737-4d6d-a9bf-c1eab2ac1b19", password: "password")


#vacations with their users and activities
# bachelorette = Vacation.create!(name: "Bachelorette", city: "Honolulu", state: "Hawaii", start_date: "2019-06-12", end_date: "2019-06-15")
#
#   bachelorette_user_1 = bachelorette.vacation_users.create!(user_id: jalena.id, role: 1)
#   bachelorette_user_2 = bachelorette.vacation_users.create!(user_id: chi.id, role: 0)
#   bachelorette_user_3 = bachelorette.vacation_users.create!(user_id: belle.id, role: 0)
#   bachelorette_user_4 = bachelorette.vacation_users.create!(user_id: lexi.id, role: 0)
#
#   hawaii_hotel = bachelorette.activities.create!(price: 600.00, num_attendees: 2, description: "Double Room", name: "Hawaii Hotel", no_of_days: 3, cutoff_date: "2019-06-10", type: FixedCost  , user_id: jalena.id, street: "400 Royal Hawaiian Avenue", city: "Honolulu", state: "HI", postal_code: "96815", country: "USA")
#
#     jalena_hawaii_hotel = UserActivity.create!(user_id: jalena.id, quantity: 1, price: 300.00, paid: true, activity_id: hawaii_hotel.id)
#     chi_hawaii_hotel = UserActivity.create!(user_id: chi.id, quantity: 1, price: 300.00, paid: false, activity_id: hawaii_hotel.id)
#
#   snorkeling = bachelorette.activities.create!(price: 200.00, num_attendees: 2, description: "Swim with the fishes", name: "Snorkeling", no_of_days: 1, cutoff_date: "2019-06-12", type: PerPersonCost, user_id: jalena.id, street: "688 Kalanipuu St", city: "Honolulu", state: "HI", postal_code: "96825", country: "USA")
#
#     jalena_snorkeling = UserActivity.create!(user_id: jalena.id, quantity: 1, price: 40.00, paid: true, activity_id: snorkeling.id)
#
#     chi_snorkeling = UserActivity.create!(user_id: chi.id, quantity: 1, price: 40.00, paid: false, activity_id: snorkeling.id)
#
#   boat_ride = bachelorette.activities.create!(price: 400.00, num_attendees: 2, description: "Sunset catamaran ride along the Napali Coast.", name: "Catamaran Tour", no_of_days: 1, cutoff_date: "2019-06-12", type: PerPersonCost, user_id: chi.id, street: "1025 Ala Moana Blvd", city: "Honolulu", state: "HI", postal_code: "96814", country: "USA")
#
#   jalena_boat = UserActivity.create!(user_id: jalena.id, quantity: 1, price: 200.00, paid: false, activity_id: boat_ride.id)
#
#   chi_boat = UserActivity.create!(user_id: chi.id, quantity: 1, price: 200.00, paid: true, activity_id: boat_ride.id)
#
#   atv_tour = bachelorette.activities.create!(price: 100.00, num_attendees: 1, description: "Let's go ATV'ing in the jungle.", name: "ATV Tour", no_of_days: 1, cutoff_date: "2019-06-12", type: PerPersonCost, user_id: chi.id, street: "560 Kamehameha Highway", city: "Kaneohe", state: "HI", postal_code: "96744", country: "USA")
#
#   chi_atv = UserActivity.create!(user_id: chi.id, quantity: 1, price: 100.00, paid: true, activity_id: atv_tour.id)
#
#
# party = Vacation.create!(name: "Party", city: "New York City", state: "NY", country: "USA", start_date: "2019-07-12", end_date: "2019-07-17")
#
#   party_user_1 = party.vacation_users.create!(user_id: earl.id, role: 1)
#   party_user_2 = party.vacation_users.create!(user_id: ethan.id, role: 0)
#   party_user_3 = party.vacation_users.create!(user_id: bear.id, role: 0)
#
#   new_york_airbnb = party.activities.create!(price: 800.00, num_attendees: 2, description: "Condo", name: "New York AirBnB", no_of_days: 5, cutoff_date: "2019-07-10", type: FixedCost, user_id: earl.id, street: "1717 Broadway", city: "New York", state: "NY", postal_code: "10019", country: "USA")
#
#       earl_new_york_airbnb = UserActivity.create!(user_id: earl.id, quantity: 1, price: 400.00, paid: false, activity_id: new_york_airbnb.id)
#
#       ethan_new_york_airbnb = UserActivity.create!(user_id: ethan.id, quantity: 1, price: 400.00, paid: false, activity_id: new_york_airbnb.id)
#
#     boat_rental = party.activities.create!(price: 400.00, num_attendees: 2, description: "For Friday & Saturday", name: "Boat Rental", no_of_days: 2, cutoff_date: "2019-07-14", type: PerPersonCost, user_id: earl.id, street: "11 Marin Blvd", city: "Jersey City", state: "NJ", postal_code: "07302", country: "USA")
#
#       earl_boat_rental = UserActivity.create!(user_id: earl.id, quantity: 1, price: 200.00, paid: false, activity_id: boat_rental.id)
#
#       ethan_boat_rental = UserActivity.create!(user_id: ethan.id, quantity: 1, price: 200.00, paid: false, activity_id: boat_rental.id)
#
# wine_tasting = Vacation.create!(name: "Wine Tasting", city: "Napa", state: "CA", start_date: "2019-08-21", end_date: "2019-08-25")
#
#   wt_user_1 = wine_tasting.vacation_users.create!(user_id: ethan.id, role: 1)
#   wt_user_2 = wine_tasting.vacation_users.create!(user_id: earl.id, role: 0)
#   wt_user_3 = wine_tasting.vacation_users.create!(user_id: jalena.id, role: 0)
#   wt_user_4 = wine_tasting.vacation_users.create!(user_id: bear.id, role: 0)
#   wt_user_5 = wine_tasting.vacation_users.create!(user_id: lexi.id, role: 0)
#
#   napa_hotel = wine_tasting.activities.create!(price: 1_200.00, num_attendees: 3, description: "3 Rooms", name: "Napa Hotel", no_of_days: 4, cutoff_date: "2019-08-19", type: FixedCost, user_id: ethan.id, street: "3425 Solano Avenue", city: "Napa", state: "CA", postal_code: "94558", country: "USA")
#
#       ethan_napa_hotel = UserActivity.create!(user_id: ethan.id, quantity: 1, price: 400.00, paid: true, activity_id: napa_hotel.id)
#
#       earl_napa_hotel = UserActivity.create!(user_id: earl.id, quantity: 1, price: 400.00, paid: false, activity_id: napa_hotel.id)
#
#       jalena_napa_hotel = UserActivity.create!(user_id: jalena.id, quantity: 1, price: 400.00, paid: false, activity_id: napa_hotel.id)
#
#
# skiing = Vacation.create!(name: "Skiing", city: "Aspen", state: "CO", start_date: "2019-12-18", end_date: "2019-12-23")
#
#   skiing_user_1 = skiing.vacation_users.create!(user_id: jalena.id, role: 1)
#   skiing_user_2 = skiing.vacation_users.create!(user_id: chi.id, role: 0)
#   skiing_user_4 = skiing.vacation_users.create!(user_id: earl.id, role: 0)
#   skiing_user_3 = skiing.vacation_users.create!(user_id: belle.id, role: 0)
#   skiing_user_5 = skiing.vacation_users.create!(user_id: lexi.id, role: 0)
#
#     aspen_hotel = skiing.activities.create!(price: 1_500.00, num_attendees: 3, description: "Moutain Lodge", name: "Aspen Hotel", no_of_days: 3, cutoff_date: "2019-12-16", type: FixedCost, user_id: jalena.id, street: "315 E Dean Street", city: "Aspen", state: "CO", postal_code: "81611", country: "USA")
#
#       jalena_aspen_hotel = UserActivity.create!(user_id: jalena.id, quantity: 1, price: 500.00, paid: true, activity_id: aspen_hotel.id)
#
#       earl_aspen_hotel = UserActivity.create!(user_id: earl.id, quantity: 1, price: 500.00, paid: false, activity_id: aspen_hotel.id)
#
#       chi_aspen_hotel = UserActivity.create!(user_id: chi.id, quantity: 1, price: 500.00, paid: false, activity_id: aspen_hotel.id)
