class AddIndexToImages < ActiveRecord::Migration[6.0]
  def change
    add_index :images, :dimensions, using: :gin
  end
end
