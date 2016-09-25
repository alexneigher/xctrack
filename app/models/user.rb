class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  validates :in_reach_share_url, presence: true, if: ->(user){user.in_reach_user?}
  validates :spot_share_url, presence: true, if: ->(user){user.spot_user?}

  has_one :most_recent_flight
  has_many :waypoints, through: :most_recent_flight, dependent: :destroy
  has_and_belongs_to_many :groups, join_table:'user_groupings'

  scope :with_waypoints, lambda { joins(most_recent_flight: :waypoints).uniq }

  enum tracker_type: [ :in_reach_user, :spot_user ]

  def full_api_url
    d1 = formatted_datetime(12.hours.ago)
    d2 = formatted_datetime(DateTime.current)

    if self.in_reach_user?
      "https://share.delorme.com/feed/Share/#{in_reach_share_url}?d1=#{d1}&d2=#{d2}"
    else
      "https://api.findmespot.com/spot-main-web/"\
      "consumer/rest-api/2.0/public/feed/#{spot_share_url}/"\
      "message.xml?startDate=#{d1}&endDate=#{d2}"
    end
  end

  def init_most_recent_flight
    most_recent_flight.destroy if most_recent_flight
    create_most_recent_flight
  end


  def fetch_coordinates

    if most_recent_flight.present? && (most_recent_flight.created_at > 5.minutes.ago)
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
      if self.in_reach_user?
        datetime.strftime('%Y-%m-%dT%H:%mZ')
      else
        datetime.strftime('%Y-%m-%dT%H:%m:%S-0000')
      end
    end

end
