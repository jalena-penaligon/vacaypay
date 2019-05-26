require 'rails_helper'

describe 'User' do
  it 'can sign in' do
    user = create(:user)

    visit '/'

    click_on 'Log In'

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_button 'Log In'

    expect(current_path).to eq(root_path)
  end

  it 'can log out' do
    user = create(:user)

    visit login_path

    fill_in'session[email]', with: user.email
    fill_in'session[password]', with: user.password

    click_button 'Log In'

    expect(current_path).to eq(root_path)

    click_on 'Log Out'

    expect(current_path).to eq(root_path)

    expect(page).to have_content('Log In')
  end

  it 'is shown an error when incorrect info is entered' do
    user = create(:user)
    fake_email = 'email@email.com'
    fake_password = '123'

    visit login_path

    fill_in'session[email]', with: fake_email
    fill_in'session[password]', with: fake_password

    click_button 'Log In'

    expect(page).to have_content('Looks like your email or password is invalid')
  end
end
