class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :otherUser_id
      t.string :content

      t.timestamps null: false
    end
  end
end
