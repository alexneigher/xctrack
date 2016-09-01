require 'rails_helper'
require 'nokogiri'

describe CoordinateFetcherService do
  context 'given valid xml' do

    let(:file){ File.read( Rails.root.join('spec', 'data', 'file.xml')) }
    let(:file_data){ Nokogiri::XML(file) }
    let(:fetcher){ CoordinateFetcherService.new(file_data) }

    it 'returns a formatted hash' do
      expect(fetcher.extract_coordinates.first).to eq(
        {:elevation => "1945m/ 6381ft",
         :latitude=>"51.275693",
         :longitude=>"-116.885690",
         :name => "Alex Neigher",
         :text => "",
         :timestamp=>"7/23/2016 4:33:15 PM",
         :velocity => "0.0 km/h"
        }
      )
    end

    it 'stores a flight on the user' do
    end
  end
end
