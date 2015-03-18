class AddVideoToTip < ActiveRecord::Migration
  def change
    add_column :tips, :video, :string
  end
end
