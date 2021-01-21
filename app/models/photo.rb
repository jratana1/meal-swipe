class Photo < ApplicationRecord
    belongs_to :restaurant
    belongs_to :user

    accepts_nested_attributes_for :restaurant

    def self.swipe_photo_search(location)
        Restaurant.where("lower(city) LIKE lower(?)", "%" + location + "%").or(Restaurant.where("zip_code LIKE ?", location)).sample.photos.sample
    end
end
