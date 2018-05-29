class CreatePostsTable < ActiveRecord::Migration[5.2]
  def change
  	create_table :posts do |t|
  		t.string :name
  		t.string :content
  		t.integer :rating
  	end
  end
end
