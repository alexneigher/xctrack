module Api
  class ExternalTrackpointsController < ApplicationController
    layout :false
    skip_before_action :verify_authenticity_token

    def create
      puts params.inspect

      device_id = params["deviceId"]
      user = User.custom_inreach_tracking_strategy.where(in_reach_share_url: device_id)&.last

      unless user.present?
        render json: { messageId: params["gatewayMessageId"], response: "Bad Message", error: "Unable to find user for deviceId #{device_id}" } and return
      end

      most_recent_flight = user.most_recent_flight.presence || user.create_most_recent_flight

      if params["latitude"].blank? || params["longitude"].blank?
        render json: { messageId: params["gatewayMessageId"], response: "Bad Message", error: "Longitude and Latitude are required params" } and return
      end

      waypoint = most_recent_flight.waypoints.create({
        elevation: params["altitude"],
        latitude: params["latitude"],
        longitude: params["longitude"],
        name: user.name,
        text: "",
        velocity: params["speed"],
        timestamp: params["deviceSendDateTime"]
      })
      # {
      #   "origin": "Device",
      #   "gatewayMessageId": 1218537031,
      #   "gatewaySendDateTime": "2019-03-11T02:11:31Z",
      #   "deviceId": "300434063321670",
      #   "deviceMessageId": 992286,
      #   "deviceTypeCode": "GIRE",
      #   "deviceSendDateTime": "2019-03-11T02:09:00Z",
      #   "latitude": -43.534204959869385,
      #   "longitude": 172.54206418991089,
      #   "batteryStatus": "Good",
      #   "deviceMessageCode": "TRACKING",
      #   "altitude": 38.89,
      #   "direction": 0,
      #   "speed": 0.0,
      #   "notifications": [
      #   ]
      # }

      render json: { messageId: params["gatewayMessageId"], response: "OK", error: "success" }
    end
  end
end