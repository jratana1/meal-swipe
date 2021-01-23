class CategoryRestaurant < ApplicationRecord
    belongs_to :restaurant
    belongs_to :category
end