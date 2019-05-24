# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

jalena = User.create!(name: "Jalena", email: "jalena@example.com", paypal_token:"ENV[JALENA_PAYPAL_TOKEN]")
earl = User.create!(name: "Earl", email: "earl@example.com", paypal_token:"ENV[EARL_PAYPAL_TOKEN]")
ethan = User.create!(name: "Ethan", email: "ethan@example.com", paypal_token:"ENV[ETHAN_PAYPAL_TOKEN]")
chi = User.create!(name: "Chi", email: "chi@example.com", paypal_token:"ENV[CHI_PAYPAL_TOKEN]")

bachelorette = Vacation.create!(name: "bachelorette", location: "Hawaii", start_date: "2019-06-12", end_date: "2019-06-15")

  bachelorette_user_1 = bachelorette.vacation_users.create!(user_id: jalena.id, role: 1)
  bachelorette_user_2 = bachelotte.vacation_users.create!(user_id: chi.id, role: 0)

  hawaii_hotel = bachelorette.activities.create!(price: 600.00, num_attendees: 2, description: "Double Room", name: "Hawaii Hotel", no_of_days: 3, cutoff_date: "2019-06-10")

    jalena_hawaii_hotel = hawaii_hotel.user_activities.create!(user_id: jalena.id, quantity: 1, price: 300.00, paid: true)

    chi_hawaii_hotel = hawaii_hotel.user_activities.create!(user_id: chi.id, quantity: 1, price: 300.00, paid: false)

  snorkling = bachelorette.activities.create!(price: 200.00, num_attendees: 2, description: "Swim with the fishes", name: "Snorkeling", no_of_days: 1, cutoff_date: "2019-06-12")

    jalena_snorkeling = snorkeling.user_activities.create!(user_id: jalena.id, quantity: 1, price: 100.00, paid: true)

    chi_snorkeling = snorkeling.user_activities.create!(user_id: chi.id, quantity: 1, price: 100.00, paid: false)

party = Vacation.create!(name: "Party", location: "Brazil", start_date: "2019-07-12", end_date: "2019-07-17")

  party_user_1 = party.vacation_users.create!(user_id: earl.id, role: 1)
  party_user_2 = party.vacation_users.create!(user_id: ethan.id, role: 0)

  brazil_airbnb = party.activities.create!(price: 800.00, num_attendees: 2, description: "Condo", name: "Brazil AirBnB", no_of_days: 5, cutoff_date: "2019-07-10")

      earl_brazil_airbnb = brazil_airbnb.user_activities.create!(user_id: earl.id, quantity: 1, price: 400.00, paid: true)

      ethan_brazil_airbnb = brazil_airbnb.user_activities.create!(user_id: ethan.id, quantity: 1, price: 400.00, paid: false)

    boat_rental = party.activities.create!(price: 400.00, num_attendees: 2, description: "For Friday & Saturday", name: "Boat Rental", no_of_days: 2, cutoff_date: "2019-07-14")

      earl_boat_rental = boat_rental.user_activities.create!(user_id: earl.id, quantity: 1, price: 200.00, paid: true)

      ethan_boat_rental = boat_rental.user_activities.create!(user_id: ethan.id, quantity: 1, price: 200.00, paid: false)

wine_tasting = Vacation.create!(name: "Wine Tasting", location: "France", start_date: "2019-08-21", end_date: "2019-08-25")

  wt_user_1 = wine_tasting.vacation_users.create!(user_id: ethan.id, role: 1)
  wt_user_2 = wine_tasting.vacation_users.create!(user_id: earl.id, role: 0)
  wt_user_3 = wine_tasting.vacation_users.create!(user_id: jalena.id, role: 0)

  france_hotel = wine_tasting.activities.create!(price: 1_200.00, num_attendees: 3, description: "3 Rooms", name: "France Hotel", no_of_days: 4, cutoff_date: "2019-08-19")

      ethan_france_hotel = france_hotel.user_activities.create!(user_id: ethan.id, quantity: 1, price: 400.00, paid: true)

      earl_france_hotel = france_hotel.user_activities.create!(user_id: earl.id, quantity: 1, price: 400.00, paid: false)

      jalena_france_hotel = france_hotel.user_activities.create!(user_id: jalena.id, quantity: 1, price: 400.00, paid: false)


skiing = Vacation.create!(name: "Skiing", location: "Aspen", start_date: "2019-12-18", end_date: "2019-12-23")

  skiing_user_1 = skiing.vacation_users.create!(user_id: jalena.id, role: 1)
  skiing_user_2 = skiing.vacation_users.create!(user_id: chi.id, role: 0)
  skiing_user_4 = skiing.vacation_users.create!(user_id: earl.id, role: 0)

    aspen_hotel = skiing.activities.create!(price: 1_500.00, num_attendees: 3, description: "Moutain Lodge", name: "Aspen Hotel", no_of_days: 3, cutoff_date: "2019-12-16")

      jalena_aspen_hotel = aspen_hotel.user_activities.create!(user_id: jalena.id, quantity: 1, price: 500.00, paid: true)

      earl_aspen_hotel = aspen_hotel.user_activities.create!(user_id: earl.id, quantity: 1, price: 500.00, paid: false)

      chi_aspen_hotel = aspen_hotel.user_activities.create!(user_id: chi.id, quantity: 1, price: 500.00, paid: false)
