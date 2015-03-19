class SecureController < FrontendController
  before_filter :ensure_correct_client!
  before_filter :authenticate_user!

  
  def index
  end
  
  private
  
  def ensure_correct_client!
    return true if params[:client_identifier] == current_user.client.identifier
    sign_out :user and return false
  end
end
