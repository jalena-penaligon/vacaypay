require 'rails_helper'

describe 'as a visitor' do
  describe 'when I visit the homepage and click on register' do
    it 'creates my account through paypal' do
      visit root_path

      expect(page).to have_link("Sign in with PayPal")
    end
  end
end
