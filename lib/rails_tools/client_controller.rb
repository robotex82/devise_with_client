module RailsTools
  module ClientController
    def set_client
      Client.current_id = Client.where(identifier: session[:client_id]).first.try(:id)
    end

    def default_url_options(options = {})
      # { :client_identifier => Client.current_id }
      { :client_identifier => Client.where(identifier: Client.current_id).first.try(:identifier) }
    end


    def self.included(base)
      base.before_filter :set_client
      base.extend(ClassMethods)
    end

    module ClassMethods
      def self.default_url_options(options = {})
        # { :client_identifier => Client.current_id }
        { :client_identifier => Client.where(identifier: Client.current_id).first.try(:identifier) }
      end
    end
  end
end


