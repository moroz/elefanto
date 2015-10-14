require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should display blog archive" do
    get :index
    assert_response :success
    assert_select 'h1', 'Blog archive' # the page must have the right header
    assert_select '.row2 .wrapper span a', 2 # there are only two fixtures
  end

  test "should display a post" do
    get :show, id: posts(:one)
    assert_response :success
    assert_select 'h3', posts(:one).title
  end
end
