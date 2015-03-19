class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable # , :validatable

  belongs_to :client
  
  delegate :identifier, to: :client, allow_nil: true, prefix: true

  validates :client_id, presence: true
  validates :email, 
            presence: true,
            uniqueness: { scope: :client_id, case_sensitive: false }
  
  default_scope { where(client_id: Client.current_id) }
end
