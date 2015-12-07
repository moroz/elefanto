require 'rails_helper'

RSpec.describe PostsController, :type => :controller do
  let(:post) { create :post }

  describe "GET show" do
    subject { get :show, :id => post.id }
    it_behaves_like 'template rendering action', :show
  end

  describe "GET #index" do
    subject { get :index }
    it_behaves_like 'template rendering action', :index
  end
end
