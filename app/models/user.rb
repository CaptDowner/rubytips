class User < ActiveRecord::Base
  has_secure_password
  
  # use Michael Hartl's regex for email validation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true, 
                    format: VALID_EMAIL_REGEX,
                    uniqueness: { case_sensitive: false }
end
