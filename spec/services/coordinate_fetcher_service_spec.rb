require 'rails_helper'
require 'nokogiri'

describe CoordinateFetcherService do
  context 'given valid xml' do

    let(:file){ File.read( Rails.root.join('spec', 'data', 'in_reach_data.xml')) }
    let(:file_data){ Nokogiri::XML(file) }
    let(:user) { create(:user, tracker_type: 0) }
    let(:fetcher){ CoordinateFetcherService }

    describe 'initialize' do
      it 'instantiates a new most recent flight' do
        fetcher.new(file_data, user)
        expect(user.most_recent_flight).to be_present
      end
    end

    describe 'extract coordinates' do
      context "for an in reach user" do

        before do
          fetcher.new(file_data, user).extract_coordinates
        end
        it 'stores the waypoints on the users most recent flight' do
          expect(user.most_recent_flight.waypoints.count).to eq 140
        end

        it 'formats the waypoints properly' do
          first_waypoint = user.most_recent_flight.waypoints.order(:id).first
          expect(first_waypoint.elevation).to eq "1945m/ 6381ft"
          expect(first_waypoint.latitude).to eq "51.275693"
          expect(first_waypoint.longitude).to eq "-116.885690"
          expect(first_waypoint.name).to eq "Alex Neigher"
          expect(first_waypoint.timestamp).to eq "Sat, 23 Jul 2016 23:33:15 UTC +00:00"
          expect(first_waypoint.text).to eq ""
        end
      end

      context 'when the user is a spot user' do
        let(:user) { create(:user, tracker_type: 1, spot_share_url: '123456789') }
        let(:file){ File.read( Rails.root.join('spec', 'data', 'spot_data.xml')) }

        before do
          fetcher.new(file_data, user).extract_coordinates
        end

        it 'stores the waypoints on the users most recent flight' do
          expect(user.most_recent_flight.waypoints.count).to eq 10
        end

        it 'formats the waypoints properly' do
          first_waypoint = user.most_recent_flight.waypoints.order(:id).last
          expect(first_waypoint.latitude).to eq "37.62857"
          expect(first_waypoint.longitude).to eq "-118.37437"
          expect(first_waypoint.name).to eq "Jai Pal Khalsa's spot"
          expect(first_waypoint.text).to eq "LANDED (OK) JaiPal Pilot 238 3104096040"
        end

      end
    end
  end
end
