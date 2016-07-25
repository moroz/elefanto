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
    find(:css, "textarea#comment_text").set(args[:text])
    page.find("input#comment_signature").set(args[:signature])
    page.find("input#comment_website").set(args[:website])
    click_button 'Send'
  end

  def valid_args
    FactoryGirl.attributes_for(:comment)
  end

  before do
    1.times { FactoryGirl.create(:post) } # fill the database with posts
  end

  it "saves a comment with valid args" do
    post1 = visit_post
    args = valid_args

    expect(current_path).to eq post_path(post1)
    puts page.body
    
    expect { fill_in_comment_form_and_click_send(args) }.to change { Comment.count }
    expect(page).to have_selector("div.comment", :count => 1)
  end

  it "doesn't save two identical comments" do
    post1 = visit_post
    args = valid_args

    expect(current_path).to eq post_path(post1)
    fill_in_comment_form_and_click_send(args)
    fill_in_comment_form_and_click_send(args)

    expect(Comment.count).to eq 1
    expect(page).to have_css("div.comment", :count => 1)
  end
end
