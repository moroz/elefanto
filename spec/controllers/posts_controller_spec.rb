require 'rails_helper'

RSpec.configure do |c|
  c.include Features::SessionHelpers
  #c.include Capybara::DSL
end

def valid_attributes
  FactoryGirl.attributes_for(:post)
end

RSpec.describe PostsController, :type => :controller do
  let(:post1) { create :post }

  it "GET show" do
    subject { get :show, :id => post1.id }
    expect(assigns[:post]).to eq(post1)
    it_behaves_like 'template rendering action', :show
  end

  it "GET #index" do
    subject { get :index }
    expect(assigns[:posts]).to eq([post1])
    it_behaves_like 'template rendering action', :index
  end

  context "when signed in" do
    before {sign_in}
    describe "GET #new" do
      subject { get :new }
      it_behaves_like 'template rendering action', :new
    end

    describe "POST #create" do
      subject { post :create, :post => { :attributes => valid_attributes} }

      it "should change Post count by 1" do
        expect{ post :create, :post => { :attributes => valid_attributes} }.to change(Post, :count).by(1)
      end

      it { is_expected.to redirect_to post_path(id: Post.last.id) }
    end
  end
end
