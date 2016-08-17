require 'rails_helper'

RSpec.describe Post do
  let!(:blog_post) { FactoryGirl.create(:post, published: false) }
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
      published_post = FactoryGirl.create(:post, title: "Published", published: true)
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

    describe "url" do
      it "creates correct urls for blog posts" do
        int_post = FactoryGirl.build_stubbed(:post, title: "Lorem ipsum", number: 108)
        dec_post = Post.create(title: "Dolor sit amet", content: "Lorem ipsum dolor sit amet", number: 666.5)
        expect(int_post.url).to eq("108-lorem-ipsum")
        expect(dec_post.to_param).to eq("666-5-dolor-sit-amet")
      end
    end

    describe "readable_number" do
      it "shows a number with a comma when number is not an integer" do
        int_post = Post.new(number: 108)
        expect(int_post.readable_number).to eq("108")
        dec_post = Post.new(number: 666.5)
        expect(dec_post.readable_number).to eq("666,5")
      end
    end
  end
end
