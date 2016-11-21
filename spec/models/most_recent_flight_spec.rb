require 'rails_helper'

RSpec.describe MostRecentFlight, type: :model do

  describe '.flight_length' do
    let!(:most_recent_flight) { create(:most_recent_flight) }

    context 'when i have 1 waypoint' do
      let!(:waypoint_1) { create(:waypoint, most_recent_flight: most_recent_flight) }

      it 'returns 0' do
        expect(most_recent_flight.flight_length).to eq 0
      end
    end

    context 'when i have enough waypoints' do
      let!(:waypoint_1) { create(:waypoint,
                          latitude: 37.773487,
                          longitude: -122.448171,
                          most_recent_flight: most_recent_flight,
                          timestamp: 3.minutes.ago)
                        }

      let!(:waypoint_3) { create(:waypoint,
                          latitude: 37.770781,
                          longitude: -122.424538,
                          most_recent_flight: most_recent_flight,
                          timestamp: 8.minutes.ago)
                        }

      it 'returns the distance between first and latest waypoints' do
        expect(most_recent_flight.flight_length).to eq 2.10
      end
    end
  end


end
