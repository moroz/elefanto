require 'rails_helper'

feature 'User views a post' do
  let(:blog_post) { FactoryGirl.create(:post, title: "Example post", number: 108) }

  describe "displaying elements of post" do
    before(:example) do
      blog_post.publish!
      visit post_path(blog_post)
    end

    specify { expect(page).to have_content "Log in" }
    specify { expect(current_path).to eq(post_path(blog_post)) }
    specify { expect(page).to have_content blog_post.title }
    specify { expect(page).to have_content blog_post.content }
    specify { expect(page).to have_content "108" }
  end

  describe "publishing status" do
    it "shows nothing when published" do
      blog_post.publish!
      visit post_path(blog_post)
      expect(page).to have_no_selector('.post__unpublished')
    end

    it "shows a div.unpublished when not published" do
      allow(blog_post).to receive(:published?).and_return(false)
      visit post_path(blog_post)
      expect(page).to have_selector('.post__unpublished')
    end
  end

end
