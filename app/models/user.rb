class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true, uniqueness: true
  validates :name, :share_url, presence: true

  has_one :most_recent_flight
  has_many :waypoints, through: :most_recent_flight, dependent: :destroy
  has_and_belongs_to_many :groups, join_table:'user_groupings'

  scope :with_waypoints, lambda { joins(most_recent_flight: :waypoints).uniq }

  def full_api_url
    d1 = formatted_datetime(12.hours.ago)
    d2 = formatted_datetime(DateTime.current)

    "https://share.delorme.com/feed/Share/#{share_url}?d1=#{d1}&d2=#{d2}"
  end

  def init_most_recent_flight
    most_recent_flight.destroy if most_recent_flight
    create_most_recent_flight
  end


  def fetch_coordinates
    if most_recent_flight.present? && (most_recent_flight.created_at > 1.minute.ago)
      # dont get new data
      # just render most recent flight

    else # get new data from the api, store it to the db
      response = HTTParty.get(full_api_url).body
      raw_xml = Nokogiri::XML(response)

      CoordinateFetcherService.new(raw_xml, self).extract_coordinates
    end

    return self.waypoints
  end

  private


    def formatted_datetime(datetime)
      datetime.strftime('%Y-%m-%dT%H:%mZ')
    end

end
