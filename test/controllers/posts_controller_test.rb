require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @user = users(:one)
    log_in_as(@user) # ログインが必要
  end

  test "ポスト詳細" do
    get post_url(@post)
    assert_response :success
  end

  test "post-newを開く" do
    get new_post_url
    assert_response :success
  end

  test "ポストとメニューのクリエイト" do
    assert_difference 'Post.count', 1 do
      assert_difference 'ArrangeMenu.count', 1 do
        post posts_url, params: { post: {
          recipe_name: 'New Recipe',
          body: 'This is a body',
          arrange_menus_attributes: [{ menu_id: menus(:one).id }] # ArrangeMenusをネスト
        } }
      end
    end
    post = Post.last
    assert_redirected_to post_url(post)
    assert_equal 'New Recipe', post.recipe_name
    assert_equal 'This is a body', post.body
    assert_equal 1, post.arrange_menus.count
  end

  test "ポスト削除" do
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end
    assert_redirected_to posts_url
  end
end
