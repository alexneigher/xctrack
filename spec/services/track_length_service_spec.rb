describe TrackLengthService do
  context 'given a set of gps points' do
    track = [
      Waypoint.new(name: 'w1',
                   latitude: 0,
                   longitude: 0,
                   timestamp: 5.minutes.ago),
      Waypoint.new(name: 'w1',
                   latitude: 1,
                   longitude: 1,
                   timestamp: 3.minutes.ago),
      Waypoint.new(name: 'w1',
                   latitude: 0,
                   longitude: 0,
                   timestamp: 1.minutes.ago)
    ]

    describe 'calculate_length' do
      it 'calculates length for an out-and-back' do
        service = TrackLengthService.new(track)
        expect(service.total_distance).to eq 314.85
        expect(service.straight_line_distance).to eq 0
      end

      it 'calculates the length for an empty track' do
        service = TrackLengthService.new([])
        expect(service.total_distance).to eq 0
        expect(service.straight_line_distance).to eq 0
      end

      context 'when a waypoint is missing a timestamp' do
        track = [
          Waypoint.new(name: 'w1',
                       latitude: 0,
                       longitude: 0,
                       timestamp: 5.minutes.ago),
          Waypoint.new(name: 'w1',
                       latitude: 1,
                       longitude: 1,
                       timestamp: 3.minutes.ago),
          Waypoint.new(name: 'w1',
                       latitude: 0,
                       longitude: 0,
                       timestamp: 1.minutes.ago),
          Waypoint.new(name: 'w1',
                       latitude: 2,
                       longitude: 2,
                       timestamp: nil)
        ]
        
        it 'calculates length for an out-and-back' do
          service = TrackLengthService.new(track)
          expect(service.total_distance).to eq 314.85
          expect(service.straight_line_distance).to eq 0
        end

      end

    end
  end
end
