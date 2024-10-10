require "test_helper"

class TopsControllerTest < ActionDispatch::IntegrationTest
  test "should get index.erb" do
    get  root_url
    assert_response :success
  end
end
