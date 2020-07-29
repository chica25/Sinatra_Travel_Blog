class CreateBlog < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.integer :user_id  
    end
  end
end


