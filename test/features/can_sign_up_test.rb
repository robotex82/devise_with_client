require "feature_test_helper"

feature "Sign up" do
  include AuthenticationHelper
  
  scenario "fails with unknown client" do
    visit '/users/sign_up'
    fill_in :user_client_identifier,     with: 'invalid_client'
    fill_in :user_email,                 with: 'john.doe@example.com'
    fill_in :user_password,              with: 'password'
    fill_in :user_password_confirmation, with: 'password'
    click_button 'Sign up'
    
    page.must_have_content "Client can't be blank"
  end

  scenario "succeeds for known client" do
    visit '/users/sign_up'
    fill_in :user_client_identifier,     with: '100'
    fill_in :user_email,                 with: 'john.doe@example.com'
    fill_in :user_password,              with: 'password'
    fill_in :user_password_confirmation, with: 'password'
    click_button 'Sign up'
    
    page.must_have_content "Welcome! You have signed up successfully."
  end

  scenario "fails for taken email address scoped to client" do
    sign_up('100', 'john.doe@example.com', 'password')

    visit '/users/sign_up'
    fill_in :user_client_identifier,     with: '100'
    fill_in :user_email,                 with: 'john.doe@example.com'
    fill_in :user_password,              with: 'password'
    fill_in :user_password_confirmation, with: 'password'
    click_button 'Sign up'
    
    page.must_have_content "Email has already been taken"    
  end

  scenario "succeeds for taken email address in a different client" do
    sign_up('100', 'john.doe@example.com', 'password')

    visit '/users/sign_up'
    fill_in :user_client_identifier,     with: clients(:client_101).identifier
    fill_in :user_email,                 with: 'john.doe@example.com'
    fill_in :user_password,              with: 'password'
    fill_in :user_password_confirmation, with: 'password'
    click_button 'Sign up'
    
    page.must_have_content "Welcome! You have signed up successfully."  
  end
end
