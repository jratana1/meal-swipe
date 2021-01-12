class FriendsController < ApplicationController
    def index
        @friends = current_user.requested_friends
    end

    def create 
        friend = User.find_by(id: params[:friend][:id])
        current_user.friend_request(friend)
        flash[:alert] = "Friend request made to #{friend.name}."
        redirect_to users_path
    end

    def update
        friend = User.find_by(id: params[:id])
        
        if params[:commit] == "Block Request"
            current_user.block_friend(friend)
            flash[:alert] = "You have blocked #{friend.name}."
            redirect_to friends_path
        else
            current_user.accept_request(friend)
            flash[:alert] = "You have friended #{friend.name}."
            redirect_to friends_path
        end
    end

    def destroy
        friend = User.find_by(id: params[:id])
        current_user.remove_friend(friend)
        flash[:alert] = "You have unfriended #{friend.name}."
        redirect_to users_path
    end
end