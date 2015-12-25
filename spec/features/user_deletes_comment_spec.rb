require 'rails_helper'

feature "User deletes a comment" do
  def valid_args
    FactoryGirl.attributes_for(:comment)
  end

  let(:post1) { FactoryGirl.create(:post) }

  before do
    sign_in(capybara: true)
    post1.comments.create(valid_args)
  end

  it "deletes a comment when delete is clicked" do
    visit post_path(id: post1.id)
    expect(Comment.count).to eq 1
    expect(page).to have_selector("div.comment", :count => 1)

    page.find("div.comment a#delete_comment").click
    expect(Comment.count).to eq 0
    expect(page).to_not have_selector("div.comment")
  end
end
