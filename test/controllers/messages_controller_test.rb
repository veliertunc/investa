require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:founder1)
  end
  # test "the truth" do
  #   assert true
  # end
end
