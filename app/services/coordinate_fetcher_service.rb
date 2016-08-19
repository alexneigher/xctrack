class CoordinateFetcherService

  def initialize(xml)
    @xml_data = xml
  end



  def extract_coordinates
    points = []
    @xml_data.css('Placemark').each do |point|
      points << format_hash_element(point)
    end
    points.pop

    points #data comes back with empty hash at the end :()
  end

  private

    def format_hash_element(point)
      point_data = point.css('ExtendedData').children
      {
        latitude: point_data.at('[@name="Latitude"]').try(:text).try(:strip),
        longitude: point_data.at('[@name="Longitude"]').try(:text).try(:strip),
        timestamp: point_data.at('[@name="Time"]').try(:text).try(:strip)
      }
    end


end
