require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user)}

  it 'has valid factory' do
    expect(user).to be_valid
  end

  describe "full_api_url" do
    it 'returns the full delorme share url' do
      expect(user.full_api_url).to include('https://share.delorme.com/feed/Share/AlexNeigher')
    end

    it 'sets D1 equal to 12 hours ago' do
      time = 12.hours.ago.strftime('%Y-%m-%dT%H:%MZ')
      expect(user.full_api_url).to include(time)
    end

    it 'sets D2 equal to current' do
      time = DateTime.current.strftime('%Y-%m-%dT%H:%MZ')
      expect(user.full_api_url).to include(time)
    end
  end

  describe 'init_most_recent_flight' do
    let!(:flight){user.create_most_recent_flight}

    it 'destroys the old flight' do
      user.init_most_recent_flight
      expect(user.most_recent_flight).to_not eq(flight)
    end

    it 'creates a new flight' do
      expect(user.most_recent_flight).to_not be_nil
    end
  end

  describe 'fetch_coordinates' do
    context 'when the data is more than 10 minutes old' do
      let!(:old_flight){ user.create_most_recent_flight(created_at: 11.minutes.ago) }

      it 'fetches new api data for old flights' do
        expect_any_instance_of(CoordinateFetcherService).to receive(:extract_coordinates)
        user.fetch_coordinates
      end
    end

    context 'when the data is less than 10 minutes old' do
      let!(:recent_flight){ user.create_most_recent_flight(created_at: 4.minutes.ago) }
      it 'returns database waypoints' do
        expect_any_instance_of(CoordinateFetcherService).to_not receive(:extract_coordinates)
        user.fetch_coordinates
      end
    end
  end
end
