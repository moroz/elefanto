require 'rails_helper'

RSpec.configure do |c|
  c.include Features::SessionHelpers
  c.include Capybara::DSL
end

RSpec.describe VisitsController, :type => :controller do
  render_views
  let(:user) { create :user }
  let(:post) { create :post }
  let(:visit) { create :visit }


  context "when not signed in" do
    describe "GET index" do
      it "denies access and redirects to root_path" do
        get :index
        expect(response).to redirect_to root_path
      end
    end

    describe "GET show" do
      it "denies access and redirects to root_path" do
        subject { get :show, :post_id => post.to_param }
        expect(response).to redirect_to root_path
      end
    end
  end

  context "when signed in" do
    before { sign_in }
    describe "GET index" do
      subject { get :index }

      it "return http success" do
        expect(response).to be_success
      end

      it "renders template index" do
        expect(response).to render_template 'index'
      end

      it "contains the visit information" do
        expect(assigns(:visits)).to eq([visit])
      end
    end

    describe "GET show" do
      subject { visit :show, post_id: post }
      it "returns http success" do
        expect(response).to be_success
      end
    end
  end
end
