require 'rails_helper'

feature "User deletes a comment" do
  let(:blog_post) { FactoryGirl.create(:post) }

  before do
    sign_in_with_capybara
    FactoryGirl.create(:comment, post: blog_post)
  end

  it "deletes a comment when delete is clicked" do
    visit post_path(blog_post)
    expect(Comment.count).to eq(1)
    expect(page).to have_selector("div.comment", :count => 1)

    page.find("a#delete_comment_#{Comment.last.id}").click
    expect(current_path).to eq(post_path(blog_post))
    expect(Comment.count).to eq(0)
    expect(page).to_not have_selector("div.comment")
  end
end
