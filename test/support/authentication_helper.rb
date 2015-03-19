require 'ostruct'

module AuthenticationHelper
  def sign_up(client_identifier, email, password)
    visit '/users/sign_up'
    fill_in :user_client_identifier,     with: client_identifier
    fill_in :user_email,                 with: email
    fill_in :user_password,              with: password
    fill_in :user_password_confirmation, with: password
    click_button 'Sign up'
  end

  def sign_in(client_identifier_or_user, email = nil, password = nil)
    if client_identifier_or_user.is_a?(User)
      user = client_identifier_or_user
    else
      user = OpenStruct.new(:client_identifier => client_identifier_or_user,
                            :email => email,
                            :password => password)
    end
    visit '/users/sign_in'
    fill_in :user_client_identifier,     with: user.client_identifier
    fill_in :user_email,                 with: user.email
    fill_in :user_password,              with: user.password
    click_button 'Log in'
  end
  
  def create_client(identifier)
    Client.create!(identifier: identifier)
  end
end
