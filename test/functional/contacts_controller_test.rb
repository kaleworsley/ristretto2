require 'test_helper'

class ContactsControllerTest < ActionController::TestCase
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
    @contact = Factory.create(:contact, :unit => @customer.units.first)
    @user = Factory.create(:user)
  end

  test "should not get index if not logged in" do
    get :index, :customer_id => @customer.to_param
    assert_redirected_to new_user_session_url
  end

  test "should get index if logged in" do
    sign_in @user
    get :index, :customer_id => @customer.to_param
    assert_response :success
    assert_not_nil assigns(:contacts)
  end

  test "should not get new if not logged in" do
    get :new, :customer_id => @customer.to_param
    assert_redirected_to new_user_session_url
  end

  test "should get new if logged in" do
    sign_in @user
    get :new, :customer_id => @customer.to_param
    assert_response :success
  end

  test "should create contact if logged in" do
    sign_in @user
    assert_difference('Contact.count') do
      post :create, :contact => @contact.attributes, :customer_id => @customer.to_param
    end

    assert_redirected_to customer_contact_path(assigns(:customer), assigns(:contact))
  end

  test "should not create contact if not logged in" do
    assert_no_difference('Contact.count') do
      post :create, :contact => @contact.attributes, :customer_id => @customer.to_param
    end

    assert_redirected_to new_user_session_url
  end

  test "should show contact if logged in" do
    sign_in @user
    get :show, :id => @contact.to_param, :customer_id => @customer.to_param
    assert_response :success
  end

  test "should not show contact if not logged in" do
    get :show, :id => @contact.to_param, :customer_id => @customer.to_param
    assert_redirected_to new_user_session_url
  end

  test "should get edit if logged in" do
    sign_in @user
    get :edit, :id => @contact.to_param, :customer_id => @customer.to_param
    assert_response :success
  end

  test "should not get edit if not logged in" do
    get :edit, :id => @contact.to_param, :customer_id => @customer.to_param
    assert_redirected_to new_user_session_url
  end

  test "should update contact if logged in" do
    sign_in @user
    put :update, :id => @contact.to_param, :contact => @contact.attributes, :customer_id => @customer.to_param
    assert_redirected_to customer_contact_path(assigns(:customer), assigns(:contact))
  end

  test "should not update contact if not logged in" do
    put :update, :id => @contact.to_param, :contact => @contact.attributes, :customer_id => @customer.to_param
    assert_redirected_to new_user_session_url
  end

  test "should destroy contact if logged in" do
    sign_in @user
    assert_difference('Contact.count', -1) do
      delete :destroy, :id => @contact.to_param, :customer_id => @customer.to_param
    end

    assert_redirected_to customer_contacts_path(assigns(:customer))
  end

  test "should not destroy contact if not logged in" do
    assert_no_difference('Contact.count') do
      delete :destroy, :id => @contact.to_param, :customer_id => @customer.to_param
    end

    assert_redirected_to new_user_session_url
  end
end

