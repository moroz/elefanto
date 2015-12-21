require 'rails_helper'

feature "Showing post list" do
  before do
    5.times { FactoryGirl.create(:post) }
    Post.all.each do |post|
      rand(1..10).times do
        FactoryGirl.create(:comment, :post => post)
      end
    end
    visit posts_path
  end

  it "shows 5 posts" do
    puts page.body
    expect(page).to have_selector("a.post__link", :count => Post.all.size)
  end

  it "shows proper comment count" do
    expect(page).to have_content("#{Post.first.comments.size} comments")
  end
end
