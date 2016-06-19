require 'rails_helper'

feature 'User views a post' do
  let(:post) { create :post }

  background do
    visit post_path(post)
    expect(page).to have_content "Log in"
  end

  it "has the correct path" do
    expect(current_path).to eq(post_path(Post.last))
  end

  it "it shows the page title" do
    expect(page).to have_content post.title
  end

  it "it shows the page content" do
    expect(page).to have_content post.content
  end

  it "it shows the page number" do
    expect(page).to have_content post.number.to_i
  end
end
