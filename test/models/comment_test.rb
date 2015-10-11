require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @comment = Post.first.comments.build
    @comment.text = "Fajna stronka, polecam"
    @comment.signature = "KJM"
    @comment.website = "http://example.com"
  end

  test "should save a comment" do
    comment = @comment

    assert comment.save
  end

  test "should not save a comment without text" do
    comment = @comment
    comment.text = ""

    assert comment.invalid?
  end

  test "should not save a comment without signature" do
    comment = @comment
    comment.signature = ""

    assert_not comment.save
  end
end
