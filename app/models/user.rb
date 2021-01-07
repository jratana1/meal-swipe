class User < ApplicationRecord
    has_secure_password
    has_friendship
    has_many :photos
    has_many :likes, dependent: :destroy
    has_many :liked_restaurants, through: :likes, source: :restaurant

    validates :name, presence: true, :uniqueness => {:case_sensitive => false}
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, confirmation: true, length: { minimum: 8 }
    validates :password_confirmation, presence: true

    extend FriendlyId
    friendly_id :name, :use => [:slugged]
end
