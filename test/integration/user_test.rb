require 'integration_test_helper'

class UserTest < ActionController::IntegrationTest
  def setup
    @user = Factory.create(:user, :email => 'test@example.com', :password => 'password')
  end

  test "viewing sign in" do
    visit '/users/sign_in'
    assert page.has_content?('Sign in')
    assert page.has_content?('Email')
    assert page.has_content?('Password')
  end

  test "viewing register" do
    visit '/register'
    assert page.has_content?('Sign up')
    assert page.has_content?('Email')
    assert page.has_content?('Password')
    assert page.has_content?('Password confirmation')
  end

  test "viewing sign out" do
    visit '/users/sign_out'
    assert_equal '/users/sign_in', page.current_path
    assert page.has_content?('You need to sign in or sign up before continuing.')
  end

  test "signing in" do
    visit '/users/sign_in'
    fill_in 'Email', :with => 'test@example.com'
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    assert_equal '/', page.current_path
    assert page.has_content?('Signed in successfully.')
  end

  test "viewing sign in as authenticated" do
    sign_in 'test@example.com', 'password'
    visit '/users/sign_in'
    assert_equal '/', page.current_path
    assert page.has_content?('You are already signed in.')
  end

  test "viewing register as authenticated" do
    sign_in 'test@example.com', 'password'
    visit '/register'
    assert_equal '/', page.current_path
    assert page.has_content?('You are already signed in.')
  end
end

