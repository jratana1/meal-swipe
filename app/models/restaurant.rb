class Restaurant < ApplicationRecord
    has_many :photos
    has_many :likes, dependent: :destroy
    has_many :liking_users, through: :likes, source: :user
    has_many :category_restaurants
    has_many :categories, through: :category_restaurants

    validates :address, presence: true
    validates :zip_code, presence: true
    validates :name, presence: true
    validates :name, uniqueness: {scope: [:address, :zip_code]}

    extend FriendlyId
    friendly_id :name, :use => [:slugged]

    accepts_nested_attributes_for :photos

    def display_address(restaurant)
        
    end

    require "json"
    require "http"
    require "optparse"
    API_HOST = "https://api.yelp.com"
    SEARCH_PATH = "/v3/businesses/search"
    BUSINESS_PATH = "/v3/businesses/"
    SEARCH_LIMIT = 50
    
    def self.api_search(location, categories = "restaurants", offset = 1)
      url = "#{API_HOST}#{SEARCH_PATH}"
      params = {
        term: "food",
        categories: categories,
        location: location,
        limit: SEARCH_LIMIT,
        offset: offset
      }
      response = HTTP.auth("Bearer #{ENV['API_KEY']}").get(url, params: params)
      response.parse["businesses"]
    end
  
    def self.api_business_reviews(business_id)
      url = "#{API_HOST}#{BUSINESS_PATH}#{business_id}/reviews"
      response = HTTP.auth("Bearer #{ENV['API_KEY']}").get(url)
      response.parse
    end
    
    def self.api_business(business_id)
      url = "#{API_HOST}#{BUSINESS_PATH}#{business_id}"
      response = HTTP.auth("Bearer #{ENV['API_KEY']}").get(url)
      response.parse
    end
    
    def self.yelp_hash_converter(hash)
        @rest_hash = {}
        @rest_hash[:name] = hash["name"]
        @rest_hash[:display_phone] = hash["display_phone"]
        @rest_hash[:rating] = hash["rating"]
        @rest_hash[:url] = hash["url"]
        @rest_hash[:address] = hash["location"]["address1"]
        @rest_hash[:city] = hash["location"]["city"]
        @rest_hash[:state] = hash["location"]["state"]
        @rest_hash[:zip_code] = hash["location"]["zip_code"]
        @rest_hash[:yelp_id] = hash["id"]
        @rest_hash[:image_url] = hash["image_url"]
        @rest_hash
    end
end
