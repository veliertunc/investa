require "test_helper"

class InvestorProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @investor_profile = investor_profiles(:one)
  end

  test "should get index" do
    get investor_profiles_url
    assert_response :success
  end

  test "should get new" do
    get new_investor_profile_url
    assert_response :success
  end

  test "should create investor_profile" do
    assert_difference("InvestorProfile.count") do
      post investor_profiles_url, params: { investor_profile: { bio: @investor_profile.bio, investment_preferences: @investor_profile.investment_preferences, name: @investor_profile.name, user_id: @investor_profile.user_id } }
    end

    assert_redirected_to investor_profile_url(InvestorProfile.last)
  end

  test "should show investor_profile" do
    get investor_profile_url(@investor_profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_investor_profile_url(@investor_profile)
    assert_response :success
  end

  test "should update investor_profile" do
    patch investor_profile_url(@investor_profile), params: { investor_profile: { bio: @investor_profile.bio, investment_preferences: @investor_profile.investment_preferences, name: @investor_profile.name, user_id: @investor_profile.user_id } }
    assert_redirected_to investor_profile_url(@investor_profile)
  end

  test "should destroy investor_profile" do
    assert_difference("InvestorProfile.count", -1) do
      delete investor_profile_url(@investor_profile)
    end

    assert_redirected_to investor_profiles_url
  end
end
