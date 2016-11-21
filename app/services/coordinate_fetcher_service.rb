class CoordinateFetcherService

  def initialize(xml, user)
    @xml_data = xml
    @user = user
    @most_recent_flight = @user.init_most_recent_flight
  end


  def extract_coordinates
    if @user.in_reach_user?
      #loop through specific in reach xml format
      @xml_data.css('Placemark').each do |point|
        @most_recent_flight.waypoints.create( format_in_reach_waypoint(point) )
      end

    else
      #loop through spot specific xml format
      @xml_data.xpath('//message').each do |point|
        @most_recent_flight.waypoints.create( format_spot_waypoint(point) )
      end
    end

    @most_recent_flight
  end

  private

    def format_spot_waypoint(point)
      {
        name: point.css('messengerName').try(:text).try(:strip).presence || 'Spot User',
        latitude: point.css('latitude').try(:text).try(:strip),
        longitude: point.css('longitude').try(:text).try(:strip),
        elevation: '',
        velocity: '',
        timestamp: format_date_time(point),
        text: format_text_message(point)
      }
    end

    def format_in_reach_waypoint(point)
      point_data = point.css('ExtendedData').children
      {
        name: point_data.at('[@name="Name"]').try(:text).try(:strip).presence || 'User',
        latitude: point_data.at('[@name="Latitude"]').try(:text).try(:strip),
        longitude: point_data.at('[@name="Longitude"]').try(:text).try(:strip),
        elevation: elevation(point_data),
        velocity: point_data.at('[@name="Velocity"]').try(:text).try(:strip),
        timestamp: format_date_time(point_data),
        text: point_data.at('[@name="Text"]').try(:text).try(:strip)
      }
    end

    def format_date_time(data)
      if @user.in_reach_user?
        return '' unless data.at('[@name="Time UTC"]').try(:text).present?
        date = data.at('[@name="Time UTC"]').text.strip
        DateTime.strptime(date, "%m/%d/%Y %I:%M:%S %P")
      else
        return '' unless data.text
        date = data.css('dateTime').text.strip
        DateTime.iso8601(date)
      end
    end

    def format_text_message(data)
      message_type = data.css('messageType').try(:text).try(:strip)
      if message_type == 'OK'
        data.css('messageContent').try(:text).try(:strip)
      else
        ''
      end
    end

    def elevation(data)
      str = data.at('[@name="Elevation"]').try(:text).try(:strip)
      return 0 unless str

      array = str.split(' m ')
      return "#{array[0].to_i}m/ #{(array[0].to_i * 3.280839895).to_i}ft"
    end

end
