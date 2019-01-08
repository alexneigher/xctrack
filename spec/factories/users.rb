FactoryBot.define do
  factory :user do
    name "John Pilot"
    sequence(:email) { |n| "john_smith_#{n}@gmail.com"}
    password '1234567890'
    in_reach_share_url 'https://share.delorme.com/feed/Share/AlexNeigher'
  end

  trait :with_waypoints do
    after(:create) do |user|
      mrf = user.create_most_recent_flight
      10.times do
        mrf.waypoints << Waypoint.new(
                          name: 'Steve',
                          latitude: Faker::Address.latitude,
                          longitude: Faker::Address.longitude,
                        )
      end
      mrf.save
    end
  end

end
