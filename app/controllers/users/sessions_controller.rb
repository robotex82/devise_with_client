module Users
  class SessionsController < Devise::SessionsController
    prepend_around_filter :scope_current_tenant_for_sign_in, :only => :create
    skip_around_filter  :scope_current_tenant, :only => :create
    skip_before_filter :set_client, :only => :create

    def scope_current_tenant_for_sign_in
      client = Client.where(identifier: params[:user][:client][:identifier]).first  
      Client.current_id = client.id if client.present?
      p "SessionsController#scope_current_tenant_for_sign_in/before: Set client to #{Client.current_id}"
      yield
    ensure
      Client.current_id = nil
      p "SessionsController#scope_current_tenant_for_sign_in/after: Set client to #{Client.current_id}"
    end
  end
end
