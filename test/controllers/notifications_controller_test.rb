require "test_helper"

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:founder1)
  end

  test "should get index" do
    get notifications_index_url
    assert_response :success
  end

  test "should get show" do
    get notifications_show_url
    assert_response :success
  end
end
