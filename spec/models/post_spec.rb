require 'rails_helper'

RSpec.describe Post do
  let!(:blog_post) { FactoryGirl.create(:post) }
  describe "publishing" do
    it "a post is not published when created" do
      expect(blog_post).not_to be_published
    end

    it "a post can be published" do
      blog_post.publish!
      expect(blog_post).to be_published
      expect(blog_post.published_at).to be_within(20).of(Time.current)
    end

    it "scope published only shows published posts" do
      published_post = FactoryGirl.create(:post, title: "Published")
      published_post.publish!
      expect(Post.published.map(&:title)).to eq(["Published"])
    end

    describe "publishing_date" do
      it "returns published_at when present" do
        blog_post.publish!
        expect(blog_post.publishing_date).to eq(blog_post.published_at)
      end

      it "returns created_at when no published_at present" do
        expect(blog_post.publishing_date).to eq(blog_post.created_at)
      end
    end
  end
end
