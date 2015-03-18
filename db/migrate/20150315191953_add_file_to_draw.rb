class AddFileToDraw < ActiveRecord::Migration
  def change
    add_column :draws, :file, :string
  end
end
