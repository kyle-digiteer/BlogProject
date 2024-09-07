class ChangeDefaultValueOfFeatured < ActiveRecord::Migration[7.1]
  def change
    change_column_default :posts, :is_featured, from: true, to: false
  end
end
