require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should display homepage" do
    get :home
    assert_response :success
    assert_select 'h1', 'Elefanto'
  end
end
