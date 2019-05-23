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

bachelorette = Vacation.create!(name: "bachelorette", location: "Hawaii", start_date: "2019-06-12", end_date: "2019-06-20")
  bachelorette_user_1 = bachelorette.vacation_users.create!(user_id: jalena.id, role: 1)
  bachelorette_user_2 = bachelotte.vacation_users.create!(user_id: chi.id, role: 0)

  # hawaii_hotel = bachelorette.activities.create!(price: 200.00, num_attendees: 2, description: "Double Room", name: "Hawaii Hotel", date:)

party = Vacation.create!(name: "Party", location: "Brazil", start_date: "2019-07-12", end_date: "2019-07-20")
  party_user_1 = party.vacation_users.create!(user_id: earl.id, role: 1)
  party_user_2 = party.vacation_users.create!(user_id: ethan.id, role: 0)
  party_user_3 = party.vacation_users.create!(user_id: jalena.id, role: 0)

wine_tasting = Vacation.create!(name: "Wine Tasting", location: "France", start_date: "2019-08-21", end_date: "2019-08-30")
  wt_user_1 = wine_tasting.vacation_users.create!(user_id: ethan.id, role: 1)
  wt_user_2 = wine_tasting.vacation_users.create!(user_id: earl.id, role: 0)
  wt_user_3 = wine_tasting.vacation_users.create!(user_id: jalena.id, role: 0)


skiing = Vacation.create!(name: "Skiing", location: "Aspen", start_date: "2019-12-18", end_date: "2019-12-23")
  skiing_user_1 = skiing.vacation_users.create!(user_id: jalena.id, role: 1)
  skiing_user_2 = skiing.vacation_users.create!(user_id: ethan.id, role: 0)
  skiing_user_4 = skiing.vacation_users.create!(user_id: earl.id, role: 0)

