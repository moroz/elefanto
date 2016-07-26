require 'rails_helper'

RSpec.describe Comment do
  describe "upon saving" do
    it "adds protocol to website" do
      comment = FactoryGirl.create(:comment, website: 'naifen.pl')
      expect(comment.website).to eq("http://naifen.pl")
    end
  end
end