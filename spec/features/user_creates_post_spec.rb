require 'rails_helper'

feature 'User creates a post' do
  valid_attr = FactoryGirl.attributes_for(:post)

  before do
    sign_in_with_capybara
    visit new_post_path
  end

  it "saves with valid attributes" do
    page.find('input#post_title').set(valid_attr[:title])
    page.find('input#post_number').set(valid_attr[:number])
    page.find('textarea#post_content').set(valid_attr[:content])
    page.find('input#post_textile_enabled').set(true)
    click_button('Send')
    expect(Post.count).to eq 1
    expect(current_path).to eq(post_path(Post.last))
    expect(page).to have_content valid_attr[:title]
    expect(page).to have_content valid_attr[:number].to_i
  end
end
