class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :type_of_taste

      t.timestamps
    end
  end
end
