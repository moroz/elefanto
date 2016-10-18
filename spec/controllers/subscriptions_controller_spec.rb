require 'rails_helper' 

RSpec.describe SubscriptionsController, type: :controller do
  describe "GET new" do
    it "passes a blank subscription" do
      get :new
      expect(assigns(:subscription)).not_to be_blank
    end
  end
end
