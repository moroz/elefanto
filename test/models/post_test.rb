require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save post without title" do
      post = Post.new
      post.title = ""
      post.number = 0
      post.content = "Foobar"
      post.description = ""
      assert_not post.save
  end

  test "should find a post by title" do
      title = "On The Long-Gone Utopia and the World on the Verge of Extiction"
      assert Post.find_by_id_or_title(title)
  end

  test "should find a post by id" do
      id = 2
      assert Post.find_by_id_or_title(id)
  end
end
