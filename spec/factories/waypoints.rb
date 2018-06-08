FactoryBot.define do
  factory :waypoint do
    latitude Faker::Address.latitude
    longitude Faker::Address.longitude
    timestamp DateTime.current.strftime('%m/%d/%Y %I:%M:%S %p') # 7/23/2016 4:33:15 PM
  end
end
