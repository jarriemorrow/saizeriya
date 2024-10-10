require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @user = users(:one)
    @like = Like.find_by(user: @user, post: @post)
    @like&.destroy
    log_in_as(@user)
  end

  test "should create like" do
    assert_difference 'Like.count', 1 do
      post likes_url, params: { post_id: @post.id }, xhr: true
    end
    assert_response :success
  end

  test "should destroy like" do
    @like = Like.create(user: @user, post: @post) 
    assert_difference('Like.count', -1) do
      delete like_url(@like), xhr: true
    end
    assert_response :success
  end
end
