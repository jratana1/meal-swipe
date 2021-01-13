class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.string :url
      t.integer :restaurant_id
      t.integer :user_id
      t.integer :leftswipes
      t.integer :rightswipes

      t.timestamps
    end
  end
end
