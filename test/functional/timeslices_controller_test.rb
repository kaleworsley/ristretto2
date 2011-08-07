require 'test_helper'

class TimeslicesControllerTest < ActionController::TestCase
  setup do
    @customer_attributes = {
      "units_attributes" => {
        "0" => {
          "name" => "Test Customer",
          "position" => "0",
          "postal_address" => "123 Fake St\r\nSomeplace",
          "physical_address" => "123 Fake St\r\nSomeplace",
          "phones_attributes" => {
            "0" => {
              "label" => "Main",
              "number" => "555 5555"
            }
          }
        }
      }
    }
    @customer = Factory.create(:customer, @customer_attributes)
    @user = Factory.create(:user)
    @ticket = Factory.create(:ticket, :unit => @customer.units.first)
    @timeslice = Factory.create(:timeslice, :timetrackable => @ticket, :created_by => @user)
  end

  test "should get index if logged in" do
    sign_in @user
    get :index
    assert_response :success
    assert_not_nil assigns(:timeslices)
  end

  test "should not get index if not logged in" do
    get :index
    assert_redirected_to new_user_session_url
  end

  test "should get new if logged in" do
    sign_in @user
    get :new
    assert_response :success
  end

  test "should not get new if not logged in" do
    get :new
    assert_redirected_to new_user_session_url
  end

  test "should create timeslice if logged in" do
    sign_in @user
    assert_difference('Timeslice.count') do
      post :create, :timeslice => @timeslice.attributes
    end

    assert_redirected_to timeslice_path(assigns(:timeslice))
  end

  test "should not create timeslice if not logged in" do
    assert_no_difference('Timeslice.count') do
      post :create, :timeslice => @timeslice.attributes
    end

    assert_redirected_to new_user_session_url
  end

  test "should show timeslice if logged in" do
    sign_in @user
    get :show, :id => @timeslice.to_param
    assert_response :success
  end

  test "should not show timeslice if not logged in" do
    get :show, :id => @timeslice.to_param
    assert_redirected_to new_user_session_url
  end

  test "should get edit if logged in" do
    sign_in @user
    get :edit, :id => @timeslice.to_param
    assert_response :success
  end

  test "should not get edit if not logged in" do
    get :edit, :id => @timeslice.to_param
    assert_redirected_to new_user_session_url
  end

  test "should update timeslice if logged in" do
    sign_in @user
    put :update, :id => @timeslice.to_param, :timeslice => @timeslice.attributes
    assert_redirected_to timeslice_path(assigns(:timeslice))
  end

  test "should not update timeslice if not logged in" do
    put :update, :id => @timeslice.to_param, :timeslice => @timeslice.attributes
    assert_redirected_to new_user_session_url
  end

  test "should destroy timeslice if logged in" do
    sign_in @user
    assert_difference('Timeslice.count', -1) do
      delete :destroy, :id => @timeslice.to_param
    end

    assert_redirected_to timeslices_path
  end

  test "should not destroy timeslice if not logged in" do
    assert_no_difference('Timeslice.count') do
      delete :destroy, :id => @timeslice.to_param
    end

    assert_redirected_to new_user_session_url
  end
end

