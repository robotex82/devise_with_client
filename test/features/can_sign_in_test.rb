require "feature_test_helper"

feature "CanSignIn" do
  include AuthenticationHelper
  
  scenario "succeeds with correct credentials" do
    @user = users(:minimal)
    
    visit '/users/sign_in'
    fill_in :user_client_identifier,     with: @user.client.identifier
    fill_in :user_email,                 with: @user.email
    fill_in :user_password,              with: User::DEFAULT_PASSWORD
    click_button 'Log in'
    
    page.must_have_content "Signed in successfully."
  end
end
