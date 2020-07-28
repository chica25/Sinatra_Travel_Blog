class CreateBlog < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :name
      t.integer :user_id  
    end
  end
end