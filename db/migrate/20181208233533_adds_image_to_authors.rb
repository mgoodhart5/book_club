class AddsImageToAuthors < ActiveRecord::Migration[5.1]
  def change
    add_column :authors, :image_link, :text
  end
end
