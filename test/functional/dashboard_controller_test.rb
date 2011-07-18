require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  setup do
    @user = Factory.create(:user)
  end

  test "should not show dashboard if not logged in" do
    get :show
    assert_redirected_to new_user_session_url
  end

  test "should show dashboard if logged in" do
    sign_in @user
    get :show
    assert_response :success
  end

end

