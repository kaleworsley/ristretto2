require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  setup do
    @customer = Factory.create(:customer)
    @user = Factory.create(:user)
  end

  test "should not get customer list if not logged in" do
    get :index
    assert_redirected_to new_user_session_url
  end

  test "should get customer list if logged in" do
    sign_in @user
    get :index
    assert_response :success
    assert_not_nil assigns(:customers)
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

  test "should create customer if logged in" do
    sign_in @user
    assert_difference('Customer.count') do
      post :create, :customer => @customer.attributes
    end

    assert_redirected_to customer_path(assigns(:customer))
  end

  test "should not create customer if not logged in" do
    post :create, :customer => @customer.attributes
    assert_redirected_to new_user_session_url
  end

  test "should show customer if logged in" do
    sign_in @user
    get :show, :id => @customer.to_param
    assert_response :success
  end

  test "should not show customer if not logged in" do
    get :show, :id => @customer.to_param
    assert_redirected_to new_user_session_url
  end

  test "should get edit if logged in" do
    sign_in @user
    get :edit, :id => @customer.to_param
    assert_response :success
  end

  test "should not get edit if not logged in" do
    get :edit, :id => @customer.to_param
    assert_redirected_to new_user_session_url
  end

  test "should update customer if logged in" do
    sign_in @user
    put :update, :id => @customer.to_param, :customer => @customer.attributes
    assert_redirected_to customer_path(assigns(:customer))
  end

  test "should not update customer if not logged in" do
    put :update, :id => @customer.to_param, :customer => @customer.attributes
    assert_redirected_to new_user_session_url
  end

  test "should destroy customer if logged in" do
    sign_in @user
    assert_difference('Customer.count', -1) do
      delete :destroy, :id => @customer.to_param
    end

    assert_redirected_to customers_path
  end

  test "should not destroy customer if not logged in" do
    delete :destroy, :id => @customer.to_param
    assert_redirected_to new_user_session_url
  end

end
