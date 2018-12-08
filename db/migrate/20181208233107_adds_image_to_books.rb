class AddsImageToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :image_link, :text
  end
end
