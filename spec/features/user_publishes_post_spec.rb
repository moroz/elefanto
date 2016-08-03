require 'rails_helper'

RSpec.describe "User publishes a post" do
  let!(:blog_post) { FactoryGirl.create(:post) }
  before do
    sign_in_with_capybara
    visit post_path(blog_post)
  end

  it "publishes a post" do
    expect(page).to have_selector('.post__unpublished')
    click_link "Publish"
    expect(page).to have_no_selector('.post__unpublished')
    blog_post.reload
    expect(blog_post).to be_published
    expect(blog_post.published_at).to be_within(10).of(Time.current)
  end

end
