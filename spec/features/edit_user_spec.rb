require 'rails_helper'

RSpec.describe "editing an existing user", type: :feature, js: true do
  let!(:user){ create(:user) }

  before do
    login_as user, scope: :user

  end
  it 'allows me to change my tracker type' do

    visit edit_user_path(user)
    choose('SPOT URL')

    fill_in 'user_spot_share_url', with: '1234567WERTY'

    click_button 'Update User'

    expect(user.reload.spot_user?).to be_truthy

  end
end
