class CreateImage < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.text :url

      t.timestamps
    end
  end
end
