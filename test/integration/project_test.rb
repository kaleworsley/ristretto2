require 'integration_test_helper'

class ProjectTest < ActionController::IntegrationTest
  def setup
    @user = Factory.create(:user, :email => 'test@example.com', :password => 'password')
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
    @project = Factory.create(:project, :customer => @customer)
  end

  test "create project" do
    sign_in 'test@example.com', 'password'
    visit '/customers/test-customer/projects'
    click_link 'New Project'

    assert_equal '/customers/test-customer/projects/new', page.current_path

    fill_in 'Name', :with => 'Test Project'
    select 'Current', :from => 'State'
    click_button 'Create Project'

    assert has_content? 'Project was successfully created.'
    assert has_content? 'Name: Test Project'
    assert has_content? 'State: Current'

    assert_equal '/customers/test-customer/projects/test-project', page.current_path
  end

  test "project list" do
    sign_in 'test@example.com', 'password'
    visit '/customers/test-customer/projects'
    assert has_content? 'Listing projects'
  end

  test "edit project" do
    sign_in 'test@example.com', 'password'
    visit '/customers/test-customer/projects'
    assert find('table').has_content? 'Project'

    click_link 'Edit'

    assert_equal '/customers/test-customer/projects/project/edit', page.current_path

    assert has_field? 'Name', :with => 'Project'
    assert has_select? 'State', :selected => 'Lead'

    fill_in 'Name', :with => 'Test Project'
    select 'Current', :from => 'State'

    click_button 'Update Project'

    assert_equal '/customers/test-customer/projects/test-project', page.current_path

    assert has_content? 'Project was successfully updated.'
    assert has_content? 'Name: Test Project'
    assert has_content? 'State: Current'
  end

  test "delete project" do
    sign_in 'test@example.com', 'password'
    visit '/customers/test-customer/projects'
    assert find('table').has_content? 'Project'
    click_link 'Destroy'
    assert_equal '/customers/test-customer/projects', page.current_path
    assert find('table').has_no_content? 'Project'
  end

end

