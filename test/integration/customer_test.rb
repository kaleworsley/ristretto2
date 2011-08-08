require 'integration_test_helper'

class CustomerTest < ActionController::IntegrationTest
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
  end

  test "create customer" do
    sign_in 'test@example.com', 'password'
    visit '/customers/new'
    assert_equal '/customers/new', current_path

    fill_in 'Name', :with => 'New Customer'
    fill_in 'Physical address', :with => '123 Fake St'
    fill_in 'Postal address', :with => '123 Fake St'
    fill_in 'Label', :with => 'Main Number'
    fill_in 'Number', :with => '555 5555'

    click_button 'Create Customer'

    assert_equal '/customers/new-customer', current_path
    assert has_content? 'Customer was successfully created.'
    assert has_content? 'New Customer'
    assert has_content? 'Name: New Customer'
    assert has_content? 'Physical Address: 123 Fake St'
    assert has_content? 'Postal Address: 123 Fake St'
    assert has_content? 'Main Number: 555 5555'
  end

  test "customer list" do
    sign_in 'test@example.com', 'password'
    visit '/customers'
    assert has_content? 'Listing customers'
    assert has_content? 'Test Customer'
  end

  test "edit customer" do
    sign_in 'test@example.com', 'password'
    visit '/customers'
    assert has_content? 'Test Customer'
    click_link 'Edit'
    assert_equal '/customers/test-customer/edit', current_path

    assert has_field? 'Name', :with => 'Test Customer'
    assert has_field? 'Physical address', :with => "123 Fake St\r\nSomeplace"
    assert has_field? 'Postal address', :with => "123 Fake St\r\nSomeplace"
    assert has_field? 'Label', :with => 'Main'
    assert has_field? 'Number', :with => '555 5555'

    fill_in 'Name', :with => 'New Customer'
    fill_in 'Physical address', :with => "123 Fake St\r\nSome other place"
    fill_in 'Postal address', :with => "123 Fake St\r\nSome other place"
    click_button 'Update Customer'
    assert has_content? 'Name: New Customer'
    assert has_content? "Physical Address: 123 Fake St Some other place"
    assert has_content? "Postal Address: 123 Fake St Some other place"
    assert has_content? 'Customer was successfully updated.'
  end

  test "delete customer" do
    sign_in 'test@example.com', 'password'
    visit '/customers'
    assert has_content? 'New Customer'
    click_link 'Destroy'
    assert_equal '/customers', current_path
    assert find('table').has_no_content? 'New Customer'
  end
end

