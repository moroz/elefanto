require 'rails_helper'

feature "Reader writes a comment" do
  def visit_post
    blog_post = Post.last
    visit posts_path
    expect(page).to have_content(blog_post.title)
    click_link(blog_post.title)
    blog_post
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

  before(:example) { FactoryGirl.create(:post) } # fill the database with posts

  it "saves a comment with valid args" do
    blog_post = visit_post

    expect(current_path).to eq post_path(blog_post)
    expect { fill_in_comment_form_and_click_send(valid_args) }.to change { Comment.count }
    expect(page).to have_selector("div.comment", count: 1)
  end

  it "doesn't save two identical comments" do
    blog_post = visit_post
    args = valid_args

    expect(current_path).to eq post_path(blog_post)
    2.times { fill_in_comment_form_and_click_send(args) }

    expect(Comment.count).to eq 1
    expect(page).to have_css("div.comment", count: 1)
  end
end
