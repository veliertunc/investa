require "application_system_test_case"

class InvestorProfilesTest < ApplicationSystemTestCase
  setup do
    @investor_profile = investor_profiles(:one)
  end

  test "visiting the index" do
    visit investor_profiles_url
    assert_selector "h1", text: "Investor profiles"
  end

  test "should create investor profile" do
    visit investor_profiles_url
    click_on "New investor profile"

    fill_in "Bio", with: @investor_profile.bio
    fill_in "Investment preferences", with: @investor_profile.investment_preferences
    fill_in "Name", with: @investor_profile.name
    fill_in "User", with: @investor_profile.user_id
    click_on "Create Investor profile"

    assert_text "Investor profile was successfully created"
    click_on "Back"
  end

  test "should update Investor profile" do
    visit investor_profile_url(@investor_profile)
    click_on "Edit this investor profile", match: :first

    fill_in "Bio", with: @investor_profile.bio
    fill_in "Investment preferences", with: @investor_profile.investment_preferences
    fill_in "Name", with: @investor_profile.name
    fill_in "User", with: @investor_profile.user_id
    click_on "Update Investor profile"

    assert_text "Investor profile was successfully updated"
    click_on "Back"
  end

  test "should destroy Investor profile" do
    visit investor_profile_url(@investor_profile)
    click_on "Destroy this investor profile", match: :first

    assert_text "Investor profile was successfully destroyed"
  end
end
