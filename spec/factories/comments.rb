FactoryGirl.define do
  factory :comment do
    text { Faker::Lorem.paragraph }
    signature { Faker::Name.name }
    website { Faker::Internet.url }
    association :post
  end
end
