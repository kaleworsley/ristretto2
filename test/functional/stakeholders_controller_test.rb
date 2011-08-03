require 'test_helper'

class StakeholdersControllerTest < ActionController::TestCase
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
    @project = Factory.create(:project, :created_by => @user, :customer => @customer)
    @stakeholder = Factory.create(:stakeholder, :user => @user, :project => @project)

  end

  test "should get index when logged in" do
    sign_in @user
    get :index, :customer_id => @customer.id, :project_id => @project.id
    assert_response :success
    assert_not_nil assigns(:stakeholders)
  end

  test "should not get index when not logged in" do
    get :index, :customer_id => @customer.id, :project_id => @project.id
    assert_redirected_to new_user_session_url
  end

  test "should get new when logged in" do
    sign_in @user
    get :new, :customer_id => @customer.id, :project_id => @project.id
    assert_response :success
  end

  test "should not get new when not logged in" do
    get :new, :customer_id => @customer.id, :project_id => @project.id
    assert_redirected_to new_user_session_url
  end

  test "should create stakeholder when logged in" do
    sign_in @user
    assert_difference('Stakeholder.count') do
      post :create, :stakeholder => @stakeholder.attributes, :customer_id => @customer.id, :project_id => @project.id
    end
    assert_redirected_to customer_project_url(@customer, @project)
  end

 test "should not create stakeholder when now logged in" do
    assert_no_difference('Stakeholder.count') do
      post :create, :stakeholder => @stakeholder.attributes, :customer_id => @customer.id, :project_id => @project.id
    end

    assert_redirected_to new_user_session_url
  end

  test "should show stakeholder when logged in" do
    sign_in @user
    get :show, :id => @stakeholder.to_param, :customer_id => @customer.id, :project_id => @project.id
    assert_response :success
  end

  test "should not show stakeholder when not logged in" do
    get :show, :id => @stakeholder.to_param, :customer_id => @customer.id, :project_id => @project.id
    assert_redirected_to new_user_session_url
  end

  test "should get edit when logged in" do
    sign_in @user
    get :edit, :id => @stakeholder.to_param, :customer_id => @customer.id, :project_id => @project.id
    assert_response :success
  end

  test "should not get edit when not logged in" do
    get :edit, :id => @stakeholder.to_param, :customer_id => @customer.id, :project_id => @project.id
    assert_redirected_to new_user_session_url
  end

  test "should update stakeholder when logged in" do
    sign_in @user
    put :update, :id => @stakeholder.to_param, :stakeholder => @stakeholder.attributes, :customer_id => @customer.id, :project_id => @project.id
    assert_redirected_to customer_project_stakeholders_url(@customer, @project)
  end

  test "should not update stakeholder when not logged in" do
    put :update, :id => @stakeholder.to_param, :stakeholder => @stakeholder.attributes, :customer_id => @customer.id, :project_id => @project.id
    assert_redirected_to new_user_session_url
  end

  test "should destroy stakeholder when logged in" do
    sign_in @user
    assert_difference('Stakeholder.count', -1) do
      delete :destroy, :id => @stakeholder.to_param, :customer_id => @customer.id, :project_id => @project.id
    end
    assert_redirected_to customer_project_stakeholders_url(@customer, @project)
  end

  test "should not destroy stakeholder when not logged in" do
    assert_no_difference('Stakeholder.count') do
      delete :destroy, :id => @stakeholder.to_param, :customer_id => @customer.id, :project_id => @project.id
    end

    assert_redirected_to new_user_session_url
  end
end

