require "test_helper"

class InvestmentProposalsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get investment_proposals_create_url
    assert_response :success
  end
end
