require "test_helper"

class Posts::LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
  end

  test "create Like by registred user" do
    @post = posts(:three)
    sign_in @user
    assert_difference("@post.likes.count", 1) do
      post post_likes_url @post
    end
    assert { @post.likes.find_by user_id: @user.id }
  end

  test "delete Like by Liker" do
    @post = posts(:one)
    @like = post_likes(:one)
    sign_in @user
    assert_difference("@post.likes.count", -1) do
      delete post_like_url @post, @like
    end
    assert_nil PostLike.find_by(id: @like.id)
  end

  test "delete Like by other user" do
    @user = users(:two)
    @post = posts(:one)
    @like = post_likes(:one)
    sign_in @user
    assert_no_difference("@post.likes.count") do
      delete post_like_url @post, @like
    end
  end

  test "can't make like twice" do
    @post = posts(:one)
    sign_in @user
    assert_no_difference("@post.likes.count") do
      post post_likes_url @post
    end
  end

  test "add like to post liked by other user" do
    @user = users(:two)
    @post = posts(:one)
    sign_in @user
    assert_difference("@post.likes.count", 1) do
      post post_likes_url @post
    end
  end
end
