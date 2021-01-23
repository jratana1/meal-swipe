class CreateCategoriesRestaurantsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_table :category_restaurants do |t|
      t.index :category_id
      t.index :restaurant_id
    end
  end
end
