require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  setup do
    @post = posts(:one)
    @newpost = Post.new(
      title: "Krótka historia o zabijaniu",
      content: "Ile jestem Ci winien, \n\rIle policzyłaś mi za swą przyjaźń?",
      number: 18,
      description: ""
    )
  end

  test "should save a post with valid data" do
    assert @newpost.valid?
  end

  test "should not save post without title" do
      post = @post
      post.title = ""

      assert post.invalid?
      assert_equal ["can't be blank"], post.errors[:title]
  end

  test "should not save post without a unique title" do
    post = Post.new(title: @post.title, content: @post.content, number: 150)

    assert post.invalid?
    assert_equal ["has already been taken"], post.errors[:title]
  end
end
