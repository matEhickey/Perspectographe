class CreateDraws < ActiveRecord::Migration
  def change
    create_table :draws do |t|
      t.integer :postIt_id
      t.string :content

      t.timestamps null: false
    end
  end
end
