class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.integer :recommend, :unsigned => true, :default => 0
      t.string :company
      t.references :category, foreign_key: true
      t.references :taste, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
