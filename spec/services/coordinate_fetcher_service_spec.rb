require 'rails_helper'
require 'nokogiri'

describe CoordinateFetcherService do
  context 'given valid xml' do

    let(:file){ File.read( Rails.root.join('spec', 'data', 'file.xml')) }
    let(:file_data){ Nokogiri::XML(file) }
    let(:user) { create(:user) }
    let(:fetcher){ CoordinateFetcherService }

    describe 'initialize' do
      it 'instantiates a new most recent flight' do
        fetcher.new(file_data, user)
        expect(user.most_recent_flight).to be_present
      end
    end

    describe 'extract coordinates' do
      before do
        fetcher.new(file_data, user).extract_coordinates
      end
      it 'stores the waypoints on the users most recent flight' do
        expect(user.most_recent_flight.waypoints.count).to eq 140
        expect(user.most_recent_flight)
      end

      it 'formats the waypoints properly' do
        first_waypoint = user.most_recent_flight.waypoints.first

        expect(first_waypoint.elevation).to eq "136m/ 446ft"
        expect(first_waypoint.latitude).to eq "37.505671"
        expect(first_waypoint.longitude).to eq "-121.904233"
        expect(first_waypoint.name).to eq "Alex Neigher"
        expect(first_waypoint.text).to eq "#08 Alex Neigher +18185167749 Landed OK."
      end
    end
  end
end
