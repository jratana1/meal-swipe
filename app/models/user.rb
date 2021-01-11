class User < ApplicationRecord
    has_secure_password
    has_friendship
    has_many :photos
    has_many :likes, dependent: :destroy
    has_many :liked_restaurants, through: :likes, source: :restaurant

    validates :name, presence: true, :uniqueness => {:case_sensitive => false}
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, confirmation: true, length: { minimum: 8 }, :allow_blank => true, :on => :update
    validates :password_confirmation, presence: true, :if => :password_confirmation

    extend FriendlyId
    friendly_id :name, :use => [:slugged]

    attr_accessor :new_password

    def self.search(search)      
        User.where("lower(name) LIKE ?", "%" + search.downcase + "%")
    end
end
