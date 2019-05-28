require 'rails_helper'

describe User do
  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_uniqueness_of :email }
  end

  describe 'relationships' do
    it { should have_many :user_activities }
    it { should have_many(:activities).through(:user_activities) }
  end

  describe 'class methods' do
    it '.check_for_existing_users' do
      user1 = User.create!(email: "joe@jimbob.com", first_name: "Joe", last_name: "Bob", password: 'password', dwolla_id: "1234567", dwolla_funding_source: "ASD-123-ASDK-134")
      miami = Vacation.create!(name: "spring break", location: "Miami", start_date: 18.days.from_now, end_date: 30.days.from_now)

      email_array = ["joe@jimbob.com", "paul@peter.com", "angie@angela.com"]
      non_existent_users = ["paul@peter.com", "angie@angela.com"]

      expect(User.check_for_existing_users(email_array, miami.id)).to eq(non_existent_users)
    end
  end

    it '.update_vacation_user_table' do
      user1 = User.create!(email: "joe@jimbob.com", first_name: "Joe", last_name: "Bob", password: 'password', dwolla_id: "1234567", dwolla_funding_source: "ASD-123-ASDK-134")
      miami = Vacation.create!(name: "spring break", location: "Miami", start_date: 18.days.from_now, end_date: 30.days.from_now)

      email_array = ["joe@jimbob.com", "paul@peter.com", "angie@angela.com"]
# binding.pry
      User.check_for_existing_users(email_array, miami.id)

      vu = VacationUser.last

      expect(vu.user_id).to eq(user1.id)
    end

end
