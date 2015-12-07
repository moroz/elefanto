require 'rails_helper'

feature 'User views a post' do
  let(:post) { create :post }

  background do
    visit post_path(id: post.id)
    expect(page).to have_content "Log in"
  end

  scenario do
    expect(page).to have_content post.title
  end
end
