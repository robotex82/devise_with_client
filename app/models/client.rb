class Client < ActiveRecord::Base
  has_many :users
  
  validates :identifier, presence: true

  class << self
    def current_id
      Thread.current[:current_client_id]
    end

    def current_id=(client_id)
      Thread.current[:current_client_id] = client_id
    end
  end
end
