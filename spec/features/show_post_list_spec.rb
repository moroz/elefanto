require 'rails_helper'

RSpec.describe "Showing post list" do
  before do
    2.times { FactoryGirl.create(:post) }
    3.times { FactoryGirl.create(:random_comment, post: Post.first) }
    visit posts_path
  end

  it "shows the proper number of posts" do
    expect(page).to have_selector(".post", :count => Post.all.size)
  end

  it "shows proper comment count" do
    expect(page).to have_content("3 comments")
  end
end
