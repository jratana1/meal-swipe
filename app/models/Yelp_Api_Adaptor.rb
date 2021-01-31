class YelpApiAdaptor < ApplicationRecord
    API_HOST = "https://api.yelp.com"
    SEARCH_PATH = "/v3/businesses/search"
    BUSINESS_PATH = "/v3/businesses/"
    SEARCH_LIMIT = 50
    
    def self.api_search(location, categories = "restaurants", offset = rand(500))
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
    
    def self.yelp_rest_hash_converter(hash)
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

    def self.yelp_cat_hash_converter(hash)
      @category_array = hash["categories"]
    end

    def self.make_restauarant(restaurant)
        @rest_hash = YelpApiAdaptor.yelp_rest_hash_converter(restaurant)
        @cat_hash = YelpApiAdaptor.yelp_cat_hash_converter(restaurant)    
        if @rest_hash[:image_url] && !Restaurant.find_by_yelp_id(@rest_hash[:yelp_id])
          restaurant = Restaurant.create(@rest_hash)            
          restaurant.photos << Photo.create(url:restaurant.image_url)          
          @cat_hash.each do |hash|
            restaurant.categories << Category.create_with(hash).find_or_create_by(title: hash["title"])
            end
        end
    end      
end