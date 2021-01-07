class Restaurant < ApplicationRecord
    has_many :photos
    has_many :likes, dependent: :destroy
    has_many :liking_users, through: :likes, source: :user

    validates :address, presence: true
    validates :zipcode, presence: true
    validates :name, presence: true, uniqueness: { scope: :address, :zipcode
    message: "already exists" }

    extend FriendlyId
    friendly_id :name, :use => [:slugged]
end
