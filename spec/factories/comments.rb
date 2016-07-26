FactoryGirl.define do
  factory :comment do
    text "You dumbass lolz"
    signature "OJ Simpson"
    website "elefanto.vot.pl"
    association :post

    factory :random_comment do
      text { Faker::Lorem.paragraph }
      signature { Faker::Name.name }
      website { Faker::Internet.url }
    end
  end
end
