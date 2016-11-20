require 'rails_helper'

RSpec.describe "visiting the homepage", type: :feature, js: true do
  let!(:user){ create(:user) }

  before do
    login_as user, scope: :user
  end

  context 'visitng the root url /' do
    context 'when nobody is flying' do
      it 'shows the empty add pilot modal' do
        visit root_path
        expect(page).to have_content 'must be unfly'
      end
    end

    context 'when someone is flying' do
      let!(:pilot_with_data){ create(:user, :with_waypoints) }

      it 'shows the add pilot modal with users to select' do
        visit root_path
        expect(page).to have_content pilot_with_data.name
      end

    end

  end

  context 'visitng with a user id in params' do
    let!(:pilot_with_data){ create(:user, :with_waypoints) }

    it 'lets me add a pilot by clicking plus' do
      visit root_path(pilots: pilot_with_data.id)
      binding.pry
      expect(page.find('.waypoint')).to be_truthy
    end
  end

end
