class User < ActiveRecord::Base
    has_secure_password
    validates :user_name, presence: true, uniqueness: { case_sensitive: false }
    has_many :blogs
end