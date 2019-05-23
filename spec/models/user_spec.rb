require 'rails_helper'

describe User do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :paypal_token }
    it { should validate_uniqueness_of :email }
  end

  describe 'relationships' do
    it { should have_many :user_activities }
    it { should have_many(:activities).through(:user_activities) }
    it { should have_one :vacation_user }
  end
end