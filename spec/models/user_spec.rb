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
end
