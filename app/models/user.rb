class User < ActiveRecord::Base


  def full_api_url
    "https://share.delorme.com/feed/Share/#{share_url}"
  end


  def fetch_coordinates
    #returns [longitude, latitude] (weird order)
    response = HTTParty.get(full_api_url).body

    raw_xml = Nokogiri::XML(response)

    coordinates = parse_xml(raw_xml).split(',').map(&:to_f)

    return [coordinates[0], coordinates[1]]
  end

  private

    def parse_xml(xml)
      #returns "value, value, value" as a string
      xml.css('coordinates').first.text
    end

end
