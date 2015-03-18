class CreateCommentaries < ActiveRecord::Migration
  def change
    create_table :commentaries do |t|
      t.integer :user_id
      t.integer :article_id
      t.string :content

      t.timestamps null: false
    end
  end
end
