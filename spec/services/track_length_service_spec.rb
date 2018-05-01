describe TrackLengthService do
  context 'given a set of gps points' do
    track = [
      Waypoint.new(name: 'w1',
                          latitude: 0,
                          longitude: 0,
                        ),
      Waypoint.new(name: 'w1',
                          latitude: 1,
                          longitude: 1,
                        ),
      Waypoint.new(name: 'w1',
                          latitude: 0,
                          longitude: 0,
                        ),
      ]

    describe 'calculate_length' do
      it 'calculates length for an out-and-back' do
        track_length = TrackLengthService.new(track).calculate_length
        expect(track_length).to eq 314.85
      end

      it 'calculates the length for an empty track' do 
        track_length = TrackLengthService.new([]).calculate_length
        expect(track_length).to eq 0
      end
    end
    

  end 
end