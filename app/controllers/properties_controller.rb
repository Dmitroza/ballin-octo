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

  def destroy
		@property = Property.find(params[:id])
		@property.destroy
		respond_to do |format|
			format.html { redirect_to root_path }
			format.json { head :no_content }
		end
  end

  def edit
		@property = Property.find(params[:id])
  end
  
	def update
		@property = Property.find(params[:id])
		
		respond_to do |format|
			if @property.update_attributes(params[:property])
				format.html { redirect_to(root_path, :notice => 'Property was successfully updated.') }
				format.json { head :no_content }
			else
				format.html { render :action => "edit" }
				format.json { render :json => @property.errors, :status => :unprocessable_entity }
			end
		end
	end
  
end
