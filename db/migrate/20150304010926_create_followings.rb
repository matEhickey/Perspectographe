class CreateFollowings < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.integer :user_id
      t.integer :followUser_id

      t.timestamps null: false
    end
  end
end
