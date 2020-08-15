class User < ActiveRecord::Base
    has_secure_password
    validates :email, presence: true, uniqueness: { case_sensitive: false }
    validates :user_name, presence: true
    has_many :blogs
end