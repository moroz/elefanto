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
    it "denies access when not signed in" do
      session.delete(:user) if session[:user].present?
      post :create, params: { post: FactoryGirl.attributes_for(:post, id: 108, title: "Example post") }
      expect(response).to redirect_to root_path
      expect(flash[:danger]).to be_present
    end

    describe "when signed in" do
      before(:each) do
        allow(controller).to receive(:current_user).and_return(double('user'))
      end

      it "redirects to new post upon success" do
        post :create, params: { post: FactoryGirl.attributes_for(:post, id: 108, title: "Example post") }
        blog_post = Post.last
        expect(response).to redirect_to post_path(blog_post)
        expect(controller.post.title).to eq("Example post")
      end

      it "renders new when the post is not saved" do
        allow_any_instance_of(Post).to receive(:save).and_return(false)
        post :create, params: { post: FactoryGirl.attributes_for(:post, id: 108, title: "Example post") }
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT update" do
    let(:blog_post) { FactoryGirl.create(:post, title: "Example post", number: 108) }

    it "denies access when not signed in" do
      session.delete(:user) if session[:user].present?
      put :update, params: { id: blog_post.to_param, post: { title: "Foobar post" } }
      expect(response).to redirect_to post_path(blog_post)
      expect(flash[:danger]).to be_present
    end

    describe "when signed in" do
      before(:each) do
        allow(controller).to receive(:current_user).and_return(double('user'))
      end

      it "updates post with correct params" do
        put :update, params: { id: blog_post.to_param, post: { content: "How much do I owe you?" } }
        expect(response).to redirect_to post_path(blog_post)
        expect(blog_post.reload.content).to eq("How much do I owe you?")
      end

      it "renders edit when not updated" do
        allow_any_instance_of(Post).to receive(:update).and_return(false)
        put :update, params: { id: blog_post.to_param, post: { content: "How much do I owe you?" } }
        expect(response).to render_template(:edit).or render_template(:new)
        expect(blog_post.reload.content).not_to eq("How much do I owe you?")
      end
    end
  end

  describe "DELETE destroy" do
    let(:blog_post) { FactoryGirl.create(:post, title: "Example post", number: 108) }

    it "denies access when not signed in" do
      session.delete(:user) if session[:user].present?
      delete :destroy, params: { id: blog_post.to_param }
      expect(response).to redirect_to post_path(blog_post)
      expect(flash[:danger]).to be_present
      expect(Post.find(blog_post.id)).not_to be_blank
    end

    describe "when signed in" do
      it "destroys post" do
        allow(controller).to receive(:current_user).and_return(double('user'))
        blog_post
        expect { delete :destroy, params: { id: blog_post.to_param } }.to change { Post.count }.by(-1)         
        expect(response).to redirect_to posts_path
        expect(flash[:success]).to be_present
      end
    end
  end

  describe "POST unpublish" do
    let(:blog_post) { FactoryGirl.create(:post, title: "Example post", number: 108) }

    it "denies access when not signed in" do
      session.delete(:user) if session[:user].present?
      blog_post.publish!
      post :unpublish, params: { id: blog_post.to_param }
      expect(response).to redirect_to post_path(blog_post)
      expect(flash[:danger]).to be_present
      blog_post.reload
      expect(blog_post).to be_published
    end

    it "unpublishes post when signed in" do
      allow(controller).to receive(:current_user).and_return(double('user'))
      blog_post.publish!
      post :unpublish, params: { id: blog_post.to_param }
      expect(response).to redirect_to post_path(blog_post)
      expect(flash[:success]).to be_present
      blog_post.reload
      expect(blog_post).not_to be_published
    end
  end

  describe "POST publish" do
    let(:blog_post) { FactoryGirl.create(:post, title: "Example post", number: 108, published: false) }

    it "denies access when not signed in" do
      session.delete(:user) if session[:user].present?
      post :publish, params: { id: blog_post.to_param }
      expect(response).to redirect_to post_path(blog_post)
      expect(flash[:danger]).to be_present
      blog_post.reload
      expect(blog_post).not_to be_published
    end

    it "publishes post when signed in" do
      allow(controller).to receive(:current_user).and_return(double('user'))
      blog_post
      post :publish, params: { id: blog_post.to_param }
      expect(response).to redirect_to post_path(blog_post)
      expect(flash[:success]).to be_present
      blog_post.reload
      expect(blog_post).to be_published
    end
  end
end
