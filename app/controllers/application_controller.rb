class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include RailsTools::ClientController   
  
  around_filter :scope_current_tenant
 
  private

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      session[:client_id] = resource.client.id
      root_path(:client_identifier => resource.client.identifier)
    else
      super
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :user
      session[:client_id] = nil
    end
    super
  end
   
  def scope_current_tenant
    Client.current_id = session[:client_id]
    p "ApplicationsController#scope_current_tenant/before: Set client to #{Client.current_id}"
    yield
  ensure
    Client.current_id = nil
    p "ApplicationsController#scope_current_tenant/after: Set client to #{Client.current_id}"
  end
end
