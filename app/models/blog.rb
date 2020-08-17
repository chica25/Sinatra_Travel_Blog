class Blog < ActiveRecord::Base 
    belongs_to :user

    validates :title, :location, :description, :image_url, presence: true
end