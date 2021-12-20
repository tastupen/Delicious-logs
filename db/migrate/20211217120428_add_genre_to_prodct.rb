class AddGenreToProdct < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :genre, index: true
  end
end
