require 'test_helper'

class TicketsControllerTest < ActionController::TestCase
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
  end

  test "should get index if logged in" do
    sign_in @user
    get :index
    assert_response :success
    assert_not_nil assigns(:tickets)
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

  test "should create ticket if logged in" do
    sign_in @user
    assert_difference('Ticket.count') do
      post :create, :ticket => @ticket.attributes
    end

    assert_redirected_to ticket_path(assigns(:ticket))
  end

  test "should not create ticket if not logged in" do
    assert_no_difference('Ticket.count') do
      post :create, :ticket => @ticket.attributes
    end

    assert_redirected_to new_user_session_url
  end

  test "should show ticket if logged in" do
    sign_in @user
    get :show, :id => @ticket.to_param
    assert_response :success
  end

  test "should not show ticket if not logged in" do
    get :show, :id => @ticket.to_param
    assert_redirected_to new_user_session_url
  end

  test "should get edit if logged in" do
    sign_in @user
    get :edit, :id => @ticket.to_param
    assert_response :success
  end

  test "should not get edit if not logged in" do
    get :edit, :id => @ticket.to_param
    assert_redirected_to new_user_session_url
  end

  test "should update ticket if logged in" do
    sign_in @user
    put :update, :id => @ticket.to_param, :ticket => @ticket.attributes
    assert_redirected_to ticket_path(assigns(:ticket))
  end

  test "should not update ticket if not logged in" do
    put :update, :id => @ticket.to_param, :ticket => @ticket.attributes
    assert_redirected_to new_user_session_url
  end

  test "should destroy ticket if logged in" do
    sign_in @user
    assert_difference('Ticket.count', -1) do
      delete :destroy, :id => @ticket.to_param
    end

    assert_redirected_to tickets_path
  end

  test "should not destroy ticket if not logged in" do
    assert_no_difference('Ticket.count') do
      delete :destroy, :id => @ticket.to_param
    end

    assert_redirected_to new_user_session_url
  end
end

