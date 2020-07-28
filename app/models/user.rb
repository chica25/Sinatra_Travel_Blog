class User < ActiveRecord::Base
    has_secure_password
    validates :username, presence: true, uniqueness: { case_sensitive: false }
    has_many :blogs
end