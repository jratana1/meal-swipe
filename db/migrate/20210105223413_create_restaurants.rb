class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.integer :rating
      t.string :name
      t.string :display_phone
      t.string :url
      t.string :address
      t.string :yelp_id
      t.string :zip_code
      t.string :city
      t.string :state
      t.string :image_url

      t.timestamps
    end
  end
end
