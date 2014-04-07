class User < ActiveRecord::Base
  has_secure_password

#  has_many :assignments
#  has_many :roles, :through => :assignments
  acts_as_user :roles =>  :author, :admin

# Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :encrypted_password, :password_confirmation, :reset_password_token, :role, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :remember_me
  # attr_accessible :title, :body
  
  ROLES = %w[admin author viewer banned]

  def initialize
  end
#TODO: finish admin method
  def admin?
    true
  end
end


class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
end

class Role < ActiveRecord::Base
  has_many :assignments
  has_many :users, :through => :assignments
end

end
