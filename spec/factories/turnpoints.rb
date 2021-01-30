FactoryBot.define do
  factory :turnpoint do
    latitude { "9.99" }
    longitude { "9.99" }
    radius { "9.99" }
    name { "MyString" }
    group { nil }
    active { false }
  end
end
