class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  validates :spot_share_url,
             presence: true,
             uniqueness: {case_sensitive: false}, if: ->(user){user.spot_user?}

  validates :in_reach_share_url,
             presence: true,
             uniqueness: {case_sensitive: false}, if: ->(user){user.in_reach_user?}

  validate :valid_spot_share_url, if: ->(user){user.spot_user?}
  validate :valid_in_reach_share_url, if: ->(user){user.in_reach_user?}

  has_one :most_recent_flight
  has_many :waypoints, through: :most_recent_flight, dependent: :destroy
  has_and_belongs_to_many :groups, join_table:'user_groupings'

  scope :with_waypoints, lambda { joins(most_recent_flight: :waypoints).uniq }

  enum tracker_type: [ :in_reach_user, :spot_user ]

  def full_api_url
    d1 = formatted_datetime(12.hours.ago)
    d2 = formatted_datetime(DateTime.current)

    if self.in_reach_user?
      "#{in_reach_share_url}?d1=#{d1}&d2=#{d2}"
    else
      "https://api.findmespot.com/spot-main-web/"\
      "consumer/rest-api/2.0/public/feed/#{spot_share_url}/"\
      "message.xml?startDate=#{d1}&endDate=#{d2}"
    end
  end

  def init_most_recent_flight
    MostRecentFlight.where(user_id: self.id).destroy_all
    create_most_recent_flight
  end


  def fetch_coordinates
    if most_recent_flight.present? && (most_recent_flight.created_at > 10.minutes.ago)
      # dont get new data
      # just render most recent flight

    else # get new data from the api, store it to the db
      response = HTTParty.get(full_api_url).body
      raw_xml = Nokogiri::XML(response)

      CoordinateFetcherService.new(raw_xml, self).extract_coordinates
    end

    return self.waypoints.order(timestamp: :desc)
  end

  private
    def valid_in_reach_share_url
      matches = in_reach_share_url&.downcase&.match('/feed\/share/').try(:[], 0)
      if matches.present?
        self.in_reach_share_url = in_reach_share_url.strip
      else
        self.errors.add(:in_reach_share_url, 'needs to bein the format of https://share.garmin.com/feed/share/{inreach name here}')
      end
    end

    def valid_spot_share_url
      #if they put the entire url in there by mistake
      if spot_share_url.include?('glId=')
        # try to grab the end part
        user_string = spot_share_url.match('.glId=(.*)').try(:[], 1)

        # if we match, just save it and move on
        if user_string.present?
          self.spot_share_url = user_string.strip
        else
          self.errors.add(:spot_share_url, 'should only be the last part (after the "glID=")')
        end

      end

      self.spot_share_url = spot_share_url.strip
    end

    def formatted_datetime(datetime)
      if self.in_reach_user?
        datetime.strftime('%Y-%m-%dT%H:%MZ')
      else
        datetime.strftime('%Y-%m-%dT%H:%M:%S-0000')
      end
    end

end
