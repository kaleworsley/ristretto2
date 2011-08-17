require 'test_helper'

class ProposalsControllerTest < ActionController::TestCase
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
    @proposal = Factory.create(:proposal, :project => @project)
  end


  test "should create proposal" do
    sign_in @user
    assert_difference('Proposal.count') do
      post :create, :proposal => @proposal.attributes, :customer_id => @customer.id, :project_id => @project.id
    end

    assert_redirected_to customer_project_proposal_path(assigns(:customer), assigns(:project))
  end

  test "should show proposal" do
    sign_in @user
    get :show, :id => @proposal.to_param, :customer_id => @customer.id, :project_id => @project.id
    assert_response 302
  end

  test "should get edit" do
    sign_in @user
    get :edit, :id => @proposal.to_param, :customer_id => @customer.id, :project_id => @project.id
    assert_response :success
  end

  test "should update proposal" do
    sign_in @user
    put :update, :id => @proposal.to_param, :proposal => @proposal.attributes, :customer_id => @customer.id, :project_id => @project.id
    assert_redirected_to customer_project_proposal_path(assigns(:customer), assigns(:project))
  end

  test "should destroy proposal" do
    sign_in @user
    assert_difference('Proposal.count', -1) do
      delete :destroy, :id => @proposal.to_param, :customer_id => @customer.id, :project_id => @project.id
    end

    assert_redirected_to customer_project_path(assigns(:customer), assigns(:project))
  end
end

