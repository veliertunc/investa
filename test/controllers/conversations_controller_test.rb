require "test_helper"

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:founder1)
  end

  test "should get index" do
    get conversations_index_url
    assert_response :success
  end

  test "should get show" do
    get conversations_show_url
    assert_response :success
  end
end
