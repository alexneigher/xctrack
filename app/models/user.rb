class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true, uniqueness: true
  validates :name, :share_url, presence: true

  has_and_belongs_to_many :groups, join_table:'user_groupings'

  def full_api_url
    d1 = formatted_datetime(12.hours.ago)
    d2 = formatted_datetime(DateTime.current)

    "https://share.delorme.com/feed/Share/#{share_url}?d1=#{d1}&d2=#{d2}"
  end


  def fetch_coordinates
    #returns {latitude: x, longitude:y, timestamp: z} hash
    response = HTTParty.get(full_api_url).body
    raw_xml = Nokogiri::XML(response)

    coordinates = CoordinateFetcherService.new(raw_xml).extract_coordinates

    return coordinates
  end

  private


    def formatted_datetime(datetime)
      datetime.strftime('%Y-%m-%dT%H:%mZ')
    end

end
