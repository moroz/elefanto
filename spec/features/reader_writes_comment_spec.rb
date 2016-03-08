require 'rails_helper'

feature "Reader writes a comment" do
  def visit_post
    post1 = Post.last
    visit posts_path
    expect(page).to have_content(post1.title)
    click_link(post1.title)
    post1
  end

  def fill_in_comment_form_and_click_send(args)
    page.find("textarea#comment_text").set(args[:text])
    page.find("input#comment_signature").set(args[:signature])
    page.find("input#comment_website").set(args[:website])
    click_button 'Send'
  end

  def valid_args
    FactoryGirl.attributes_for(:comment)
  end

  def accepted_urls(post1)
    [post_path(id: post1.id, locale: 'en'), post_path(id: post1.id)]
  end

  before do
    5.times { FactoryGirl.create(:post) } # fill the database with posts
  end

  it "saves a comment with valid args" do
    post1 = visit_post
    args = valid_args

    expect(accepted_urls(post1)).to include(current_path)
    fill_in_comment_form_and_click_send(args)

    expect(Comment.count).to eq 1
    expect(page).to have_selector("div.comment", :count => 1)
  end

  it "doesn't save two identical comments" do
    post1 = visit_post
    args = valid_args

    expect(accepted_urls(post1)).to include(current_path)
    2.times { fill_in_comment_form_and_click_send(args) }

    expect(Comment.count).to eq 1
    expect(page).to have_selector("div.comment", :count => 1)
  end
end
