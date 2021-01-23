class Photo < ApplicationRecord
    belongs_to :restaurant
    belongs_to :user, optional: true

    accepts_nested_attributes_for :restaurant

    def self.swipe_photo_search(location)
        location = location.split(",").map {|string| string.squish}
        if location[1]
            Restaurant.where("lower(city) LIKE lower(?) AND lower(state) LIKE lower(?)", "%" + location[0] + "%", location[1]).or(Restaurant.where("zip_code LIKE ?", location[0])).sample.photos.sample
        else
            Restaurant.where("lower(city) LIKE lower(?)", "%" + location[0] + "%").or(Restaurant.where("zip_code LIKE ?", location[0])).sample.photos.sample
        end
    end
end

