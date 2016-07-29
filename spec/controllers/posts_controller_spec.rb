require 'rails_helper'

RSpec.describe PostsController do
  describe "GET index" do
    before { 2.times { FactoryGirl.create(:post) } }
    it "gets posts" do
      get :index
      expect(controller.posts.count).to eq(2)
    end
  end

  describe "GET show" do
    before { FactoryGirl.create(:post, title: "Example post", number: 108) }
    it "shows the correct post" do
      get :show, params: { id: "108-example-post" }
      expect(controller.post.number).to eq(108)
    end
  end

  describe "POST create" do
    describe "upon success" do
      it "redirects to new post" do
        user = double('user')
        allow(controller).to receive(:current_user).and_return(user)
        post :create, params: { post: FactoryGirl.attributes_for(:post, id: 108, title: "Example post") }
        blog_post = Post.last
        expect(response).to redirect_to post_path(blog_post)
        expect(controller.post.title).to eq("Example post")
      end
    end
  end
end