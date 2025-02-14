require "test_helper"

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:founder1)
  end

  test "should get show" do
    get dashboards_show_url
    assert_response :success
  end
end
