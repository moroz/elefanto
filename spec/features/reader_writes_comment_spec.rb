require 'rails_helper'

RSpec.describe "Reader writes a comment", js: true do
  def fill_in_comment_form_and_click_send
    find("textarea#comment_text").set("The quick brown fox jumps over the lazy dog.")
    find("input#comment_signature").set("OJ Simpson")
    find("input#comment_website").set("www.example.com")
    click_button 'Send'
  end

  let!(:blog_post) { FactoryGirl.create(:post) } # fill the database with posts

  before(:each) do
    visit posts_path
    click_link blog_post.title
  end 

  it "saves a comment with valid args" do
    expect(current_path).to eq post_path(blog_post)
    fill_in_comment_form_and_click_send
    expect(page).to have_selector("div.comment", count: 1)
    blog_post.reload
    expect(blog_post.comments.count).to eq(1)
  end
  
  it "doesn't save two identical comments" do
    expect(current_path).to eq post_path(blog_post)
    2.times { fill_in_comment_form_and_click_send }
    expect(Comment.count).to eq 1
    expect(page).to have_css("div.comment", count: 1)
  end
end
