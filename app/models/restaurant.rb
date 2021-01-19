class Restaurant < ApplicationRecord
    has_many :photos
    has_many :likes, dependent: :destroy
    has_many :liking_users, through: :likes, source: :user

    validates :address, presence: true
    validates :zip_code, presence: true
    validates :name, presence: true
    validates :name, uniqueness: {scope: [:address, :zip_code]}

    extend FriendlyId
    friendly_id :name, :use => [:slugged]

    accepts_nested_attributes_for :photos

    def display_address(restaurant)
        
    end
end
