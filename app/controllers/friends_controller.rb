class FriendsController < ApplicationController
    def index
        #pending friend
        #requested friends
    end

    def create
        #friend
        
        friend = User.find_by(id: params[:friend][:id])
        current_user.friend_request(friend)
        flash[:alert] = "Friend request made to #{friend.name}."
        byebug
        redirect_to users_path
    end

    def update
        #add/reject
    end

    def destroy
        #unfriend
    end
end