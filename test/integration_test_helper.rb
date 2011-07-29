require "test_helper"
require "capybara/rails"

class ActionController::IntegrationTest
  include Capybara::DSL

  # Go to sign in page, fill out form and click Sign in
  # User should already exist
  def sign_in(email, password)
    visit '/users/sign_in'
    fill_in 'Email', :with => email
    fill_in 'Password', :with => password
    click_button 'Sign in'
  end
end

