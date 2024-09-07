class ModifyPostActiveFeaturedColumns < ActiveRecord::Migration[7.1]
  def change
    change_column_default :posts, :is_active, to: true
    change_column_default :posts, :is_featured, to: false

  end
end
