require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one) # fixturesからユーザーを取得
    log_in_as(@user) # ログインが必要ならセットアップ
  end

  test "ユーザー詳細" do
    get user_url(@user)
    assert_response :success
  end

  test "新規登録画面チェック" do
    get new_user_url
    assert_response :success
  end

  test "新規ユーザー作成" do
    assert_difference 'User.count', 1 do
      post users_url, params: { user: { name: "Test User", email: "test@example.com", password: "password", password_confirmation: "password" } }
    end
    assert_redirected_to root_url
  end

  test "ユーザー情報更新画面" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "ユーザー情報更新" do
    patch user_url(@user), params: { user: { name: 'Updated Name', email: @user.email } }
    assert_redirected_to user_url(@user) # ユーザーの詳細ページにリダイレクト
  end

  test "ユーザー削除" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end
    assert_redirected_to users_url # ユーザー一覧にリダイレクト
  end

  test "未ログイン時に編集画面に飛ぶとログインにリダイレクトする" do
    delete logout_url # ログアウト
    get edit_user_url(@user)
    assert_redirected_to login_url # ログインページにリダイレクト
  end

  test "未ログイン時にユーザー情報を更新しようとするとログインにリダイレクトする" do
    delete logout_url # ログアウト
    patch user_url(@user), params: { user: { name: @user.name, email: @user.email } }
    assert_redirected_to login_url # ログインページにリダイレクト
  end

  test "未ログイン時にユーザー削除するとログインにリダイレクトする" do
    delete logout_url # ログアウト
    assert_no_difference('User.count') do
      delete user_url(@user)
    end
    assert_redirected_to login_url # ログインページにリダイレクト
  end
end
