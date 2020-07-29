class AddTitleLocationDescriptionAndImageToBlog < ActiveRecord::Migration
    def change
      add_column :blogs, :title, :string
      add_column :blogs, :location, :string
      add_column :blogs, :description, :string
      add_column :blogs, :image, :string
  end
end

