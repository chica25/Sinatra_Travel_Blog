class User < ActiveRecord::Base
    has_many :blogs
    has_secure_password
    validates :user_name, :email, presence: true, uniqueness: { case_sensitive: false }
   # validates :user_name, presence: true
    
end
