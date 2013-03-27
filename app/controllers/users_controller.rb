class UsersController < ApplicationController

	def show
		@user = User.find params[:id]
	end

  def index	
  	@users = User.all 
  	respond_to do |format|
			format.html # index.html.haml
			format.json { render :json => @users }
		end 	 
  end
  
end