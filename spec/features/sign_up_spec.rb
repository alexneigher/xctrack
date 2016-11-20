require 'rails_helper'


RSpec.describe "signing up as a new user", type: :feature, js: true do

  it 'allows me to follow the sign up flow' do
    visit 'users/sign_up'

    fill_in 'user_name', with: 'Alex Neigher'
    fill_in 'user_email', with: 'alex@wow.com'
    fill_in 'user_in_reach_share_url', with: 'AlexNeigher'
    fill_in 'user_password', with: '1234567890'
    fill_in 'user_password_confirmation', with: '1234567890'
    click_button 'Sign up'

    expect(User.count).to eq 1
  end
end
