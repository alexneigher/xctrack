class CoordinateFetcherService

  def initialize(xml, user)
    @xml_data = xml
    @most_recent_flight = user.init_most_recent_flight
  end


  def extract_coordinates

    @xml_data.css('Placemark').each do |point|
      @most_recent_flight.waypoints.create( format_hash_element(point) )
    end

    @most_recent_flight
  end

  private

    def format_hash_element(point)
      point_data = point.css('ExtendedData').children
      {
        name: point_data.at('[@name="Name"]').try(:text).try(:strip),
        latitude: point_data.at('[@name="Latitude"]').try(:text).try(:strip),
        longitude: point_data.at('[@name="Longitude"]').try(:text).try(:strip),
        elevation: elevation(point_data),
        velocity: point_data.at('[@name="Velocity"]').try(:text).try(:strip),
        timestamp: point_data.at('[@name="Time"]').try(:text).try(:strip),
        text: point_data.at('[@name="Text"]').try(:text).try(:strip)
      }
    end

    def elevation(data)
      str = data.at('[@name="Elevation"]').try(:text).try(:strip)
      return 0 unless str

      array = str.split(' m ')
      return "#{array[0].to_i}m/ #{(array[0].to_i * 3.280839895).to_i}ft"
    end

end
