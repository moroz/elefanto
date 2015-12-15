FactoryGirl.define do
  factory :post do
    number  110
    title   "My New Year's resolution"
    updated_at  "2011-02-03 14:10:13 UTC"
    created_at  "2011-02-03 14:10:13 UTC"
    textile_enabled true
    content "This is the content of the post number 110."
  end
end
