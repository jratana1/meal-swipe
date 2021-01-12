class FriendsController < ApplicationController
    def index
        #list pending friend
        #list requested friends
    end

    def create 
        friend = User.find_by(id: params[:friend][:id])
        current_user.friend_request(friend)
        flash[:alert] = "Friend request made to #{friend.name}."
        redirect_to users_path
    end

    def update
        #add/reject pending
    end

    def destroy
        #unfriend
        byebug
        friend = User.find_by(id: params[:id])
        current_user.remove_friend(friend)
        flash[:alert] = "You have unfriended #{friend.name}."
        redirect_to users_path
    end
end