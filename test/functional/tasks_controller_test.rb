require 'test_helper'

class TasksControllerTest < ActionController::TestCase
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
    @task = Factory.create(:task, :project => @project)

  end

  test "should get index when logged in" do
    sign_in @user
    get :index, :customer_id => @customer.id, :project_id => @project.id
    assert_response :success
    assert_not_nil assigns(:tasks)
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

  test "should create task when logged in" do
    sign_in @user
    assert_difference('Task.count') do
      post :create, :task => @task.attributes, :customer_id => @customer.id, :project_id => @project.id
    end
    assert_redirected_to customer_project_url(@customer, @project)
  end

 test "should not create task when now logged in" do
    assert_no_difference('Task.count') do
      post :create, :task => @task.attributes, :customer_id => @customer.id, :project_id => @project.id
    end

    assert_redirected_to new_user_session_url
  end


  test "should show task if logged in" do
    sign_in @user
    get :show, :id => @task.to_param, :customer_id => @customer.id, :project_id => @project.id
    assert_response :success
  end

  test "should not show task if not logged in" do
    get :show, :id => @task.to_param, :customer_id => @customer.id, :project_id => @project.id
    assert_redirected_to new_user_session_url
  end

  test "should get edit when logged in" do
    sign_in @user
    get :edit, :id => @task.to_param, :customer_id => @customer.id, :project_id => @project.id
    assert_response :success
  end

  test "should not get edit when not logged in" do
    get :edit, :id => @task.to_param, :customer_id => @customer.id, :project_id => @project.id
    assert_redirected_to new_user_session_url
  end

  test "should update task when logged in" do
    sign_in @user
    put :update, :id => @task.to_param, :task => @task.attributes, :customer_id => @customer.id, :project_id => @project.id
    assert_redirected_to customer_project_tasks_url(@customer, @project)
  end

  test "should not update task when not logged in" do
    put :update, :id => @task.to_param, :task => @task.attributes, :customer_id => @customer.id, :project_id => @project.id
    assert_redirected_to new_user_session_url
  end

  test "should destroy task when logged in" do
    sign_in @user
    assert_difference('Task.count', -1) do
      delete :destroy, :id => @task.to_param, :customer_id => @customer.id, :project_id => @project.id
    end
    assert_redirected_to customer_project_tasks_url(@customer, @project)
  end

  test "should not destroy task when not logged in" do
    assert_no_difference('Task.count') do
      delete :destroy, :id => @task.to_param, :customer_id => @customer.id, :project_id => @project.id
    end

    assert_redirected_to new_user_session_url
  end
end

