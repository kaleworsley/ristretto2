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
  end

  test "should get index" do
    get :index, :customer_id => @customer.to_param
    assert_response :success
    assert_not_nil assigns(:contacts)
  end

  test "should get new" do
    get :new, :customer_id => @customer.to_param
    assert_response :success
  end

  test "should create contact" do
    assert_difference('Contact.count') do
      post :create, :contact => @contact.attributes, :customer_id => @customer.to_param
    end

    assert_redirected_to customer_contact_path(assigns(:customer), assigns(:contact))
  end

  test "should show contact" do
    get :show, :id => @contact.to_param, :customer_id => @customer.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @contact.to_param, :customer_id => @customer.to_param
    assert_response :success
  end

  test "should update contact" do
    put :update, :id => @contact.to_param, :contact => @contact.attributes, :customer_id => @customer.to_param
    assert_redirected_to customer_contact_path(assigns(:customer), assigns(:contact))
  end

  test "should destroy contact" do
    assert_difference('Contact.count', -1) do
      delete :destroy, :id => @contact.to_param, :customer_id => @customer.to_param
    end

    assert_redirected_to customer_contacts_path(assigns(:customer))
  end
end

