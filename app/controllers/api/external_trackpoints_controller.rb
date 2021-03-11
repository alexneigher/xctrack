module Api
  class ExternalTrackpointsController < ApplicationController
    layout :false
    skip_before_action :verify_authenticity_token

    def create
      puts params.inspect
      message_id = params["gatewayMessageId"]
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

      render json: { messageId: message_id, response: "OK", error: "success" }
    end
  end
end