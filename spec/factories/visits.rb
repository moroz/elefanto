FactoryGirl.define do
  factory :visit do
    association :post_id, :factory => :post
    ip { Faker::Internet.public_ip_v4_address }
    browser "Chrome 30.0.1599.12 mobile other"
    city { Faker::Address.city }
    country { Faker::Address.country }
    timestamp { Faker::Time.backward(7, :evening) }
  end
end
