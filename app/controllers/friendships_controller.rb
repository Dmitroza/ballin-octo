class FriendshipsController < ApplicationController


	def create

		#logger.debug 'returnpath:'
		#logger.debug session[:return_to]
		#logger.debug session.inspect

		friend = User.find params[:friend_id]
		unless current_user.can_add_friend?(friend)
	    flash[:notice] = "Unable to add friend."
	    redirect_to request.referer #session[:return_to]
	    return
		end
		@friendship = current_user.friendships.build(:friend_id => friend.id)
    flash[:notice] = @friendship.save ? "Added friend." : "Unable to add friend."
    redirect_to request.referer #session[:return_to]
	end

	def destroy
		@friendship = current_user.friendships.find(params[:id])
	  @friendship.destroy
	  flash[:notice] = "Removed friendship."
	  redirect_to current_user
	end

end
