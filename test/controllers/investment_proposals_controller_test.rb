require "test_helper"

class InvestmentProposalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:investor1)
  end

  test "should get create" do
    get investment_proposals_create_url
    assert_response :success
  end
end
