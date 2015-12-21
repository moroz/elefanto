require 'rails_helper'

feature "Reader writes a comment" do
  args = FactoryGirl.attributes_for(:comment)

  before do
    5.times { FactoryGirl.create(:post) } # fill the database with posts
  end

  it "saves a comment with valid args" do
    post1 = Post.last
    visit posts_path
    expect(page).to have_content(post1.title)
    click_link(post1.title)

    expect(current_path).to eq post_path(id: post1.id, locale: 'en')
    page.find("textarea#comment_text").set(args[:text])
    page.find("input#comment_signature").set(args[:signature])
    page.find("input#comment_website").set(args[:website])
    click_button 'Send'

    expect(Comment.count).to eq 1
    expect(page).to have_content args[:text]
  end
end
