FactoryGirl.define do
  factory :post do
    transient do
      published true
    end

    number { rand(25..150) }
    title { Faker::Lorem.sentence }
    updated_at { Faker::Time.backward(14, :evening) }
    created_at { Faker::Time.backward(13, :evening) }
    textile_enabled true
    content { Faker::Lorem.paragraph(1) }
    url { "#{number} #{title}".to_url }

    after(:create) do |post,evaluator|
      post.publish! if evaluator.published
    end
  end
end
