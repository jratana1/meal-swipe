module RestaurantsHelper
    def photo_field(action, f)
        if action == "new"   
            f.fields_for :photos do |photo|
            photo.label :Photo_url
            photo.text_field :url
            end
        end
    end
      
end
