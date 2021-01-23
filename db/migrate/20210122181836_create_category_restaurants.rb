class CreateCategoryRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :category_restaurants do |t|
      t.integer :category_id
      t.integer :restaurant_id
    end
  end
end
