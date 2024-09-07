class AddColumnsToPost < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :is_active, :boolean, default: true
    add_column :posts, :is_featured, :boolean, default: false
  end
end
