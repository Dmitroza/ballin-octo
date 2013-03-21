class PropertiesController < ApplicationController
  def index
  	@properties = Property.all 
  	respond_to do |format|
			format.html # index.html.erb
			format.json { render :json => @properties }
		end 	 
  end

  def new
  	@property = Property.new
  end
  def create 
  	@property = Property.new(params[:property])
		if @property.save
			redirect_to root_path
		else
			render :action => "new"
		end
  end	
  
end
