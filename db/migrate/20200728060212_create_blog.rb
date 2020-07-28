class CreateBlog < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.integer :user_id
      t.string :photographs   
    end
  end
end