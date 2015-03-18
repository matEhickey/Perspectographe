class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :pseudo
      t.string :password
      t.string :firstname
      t.string :name
      t.string :email
      t.integer :age

      t.timestamps null: false
    end
  end
end
