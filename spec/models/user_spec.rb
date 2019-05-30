require 'rails_helper'

describe User do
  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_uniqueness_of :email }
  end

  describe 'relationships' do
    it { should have_many :user_activities }
    it { should have_many :messages }
    it { should have_many(:activities).through(:user_activities) }
  end

  describe 'class methods' do
    it '.check_for_existing_users' do
      user1 = User.create!(email: "joe@jimbob.com", first_name: "Joe", last_name: "Bob", password: 'password', dwolla_id: "1234567", dwolla_funding_source: "ASD-123-ASDK-134")
      user2 = User.create!(email: "jack@jill.com", first_name: "Jack", last_name: "Jill", password: 'password', dwolla_id: "2345678", dwolla_funding_source: "ASD-456-ASDK-789")
      miami = Vacation.create!(name: "spring break", location: "Miami", start_date: 18.days.from_now, end_date: 30.days.from_now)
      vu1 = VacationUser.create!(role: 1, user_id: user2.id, vacation_id: miami.id)

      email_array = ["joe@jimbob.com", "paul@peter.com", "angie@angela.com"]
      non_existent_users = ["paul@peter.com", "angie@angela.com"]

      expect(User.check_for_existing_users(user2, email_array, miami.id)).to eq(non_existent_users)
    end

    it '.update_vacation_user_table' do
      user1 = User.create!(email: "joe@jimbob.com", first_name: "Joe", last_name: "Bob", password: 'password', dwolla_id: "1234567", dwolla_funding_source: "ASD-123-ASDK-134")
      user2 = User.create!(email: "jack@jill.com", first_name: "Jack", last_name: "Jill", password: 'password', dwolla_id: "2345678", dwolla_funding_source: "ASD-456-ASDK-789")
      miami = Vacation.create!(name: "spring break", location: "Miami", start_date: 18.days.from_now, end_date: 30.days.from_now)
      vu1 = VacationUser.create!(role: 1, user_id: user2.id, vacation_id: miami.id)
      email_array = ["joe@jimbob.com", "paul@peter.com", "angie@angela.com"]

      User.add_existing_user(user2, email_array, miami.id)

      vu = VacationUser.last

      expect(vu.user_id).to eq(user1.id)
    end
  end
end
