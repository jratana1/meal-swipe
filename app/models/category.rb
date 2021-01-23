class Category < ApplicationRecord
    has_many :restaurants, through: :category_restaurants
end
