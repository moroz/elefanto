FactoryGirl.define do
  factory :post do
    number { rand(25..150) }
    title { Faker::Lorem.sentence }
    updated_at { Faker::Time.backward(14, :evening) }
    created_at { Faker::Time.backward(13, :evening) }
    textile_enabled true
    content { Faker::Lorem.paragraph(3) }
  end
end
