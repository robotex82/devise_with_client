module Users
  class RegistrationsController < Devise::RegistrationsController
    prepend_around_filter :scope_current_tenant_for_registration, :only => :create
    skip_around_filter  :scope_current_tenant, :only => :create
    skip_before_filter :set_client, :only => :create

    def scope_current_tenant_for_registration
      client = Client.where(identifier: params[:user][:client][:identifier]).first  
      Client.current_id = client.id if client.present?
      p "SessionsController#scope_current_tenant_for_sign_in/before: Set client to #{Client.current_id}"
      yield
    ensure
      Client.current_id = nil
      p "SessionsController#scope_current_tenant_for_sign_in/after: Set client to #{Client.current_id}"
    end
    
    def registration_params
      params.require(:user).permit({:client => [:identifier]}, :email, :password, :password_confirmation)
    end
  end
end
