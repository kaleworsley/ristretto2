require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
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
    @project = Factory.create(:project, :customer => @customer)
  end

  test "should get index when logged in" do
    sign_in @user
    get :index, :customer_id => @customer.id
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should not get index when logged in" do
    get :index, :customer_id => @customer.id
    assert_redirected_to new_user_session_url
  end

  test "should get new when logged in" do
    sign_in @user
    get :new, :customer_id => @customer.id
    assert_response :success
  end

  test "should not get new when logged in" do
    get :new, :customer_id => @customer.id
    assert_redirected_to new_user_session_url
  end

  test "should create project when logged in" do
    sign_in @user
    assert_difference('Project.count') do
      post :create, :project => @project.attributes, :customer_id => @customer.id
    end

    assert_redirected_to customer_project_path(@customer, assigns(:project))
  end

  test "should not create project when logged in" do
    post :create, :project => @project.attributes, :customer_id => @customer.id
    assert_redirected_to new_user_session_url
  end

  test "should show project when logged in" do
    sign_in @user
    get :show, :id => @project.to_param, :customer_id => @customer.id
    assert_response :success
  end

  test "should not show project when logged in" do
    get :show, :id => @project.to_param, :customer_id => @customer.id
    assert_redirected_to new_user_session_url
  end

  test "should get edit when logged in" do
    sign_in @user
    get :edit, :id => @project.to_param, :customer_id => @customer.id
    assert_response :success
  end

  test "should not get edit when logged in" do
    get :edit, :id => @project.to_param, :customer_id => @customer.id
    assert_redirected_to new_user_session_url
  end

  test "should update project when logged in" do
    sign_in @user
    put :update, :id => @project.to_param, :project => @project.attributes, :customer_id => @customer.id
    assert_redirected_to customer_project_path(@customer, assigns(:project))
  end

  test "should not update project when logged in" do
    put :update, :id => @project.to_param, :project => @project.attributes, :customer_id => @customer.id
    assert_redirected_to new_user_session_url
  end

  test "should destroy project when logged in" do
    sign_in @user
    assert_difference('Project.count', -1) do
      delete :destroy, :id => @project.to_param, :customer_id => @customer.id
    end

    assert_redirected_to customer_projects_path(@customer)
  end

  test "should not destroy project when logged in" do
    delete :destroy, :id => @project.to_param, :customer_id => @customer.id
    assert_redirected_to new_user_session_url
  end
end

