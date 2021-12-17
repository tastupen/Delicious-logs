class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|
      t.string :major_category_name
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
