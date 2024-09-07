class AddDateToPost < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :published_date, :date, default: Date.today
  end
end
