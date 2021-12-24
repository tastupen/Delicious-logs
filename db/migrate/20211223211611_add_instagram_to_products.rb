class AddInstagramToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :instagram, :boolean, default: false
  end
end
