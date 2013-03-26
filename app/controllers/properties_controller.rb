class PropertiesController < ApplicationController

	def show
		@property = Property.find params[:id]
	end

  def index
  	@properties = Property.all 
  	respond_to do |format|
			format.html # index.html.haml
			format.json { render :json => @properties }
		end 	 
  end

  def new
  	@property = Property.new
  end

  def create 
  	@property = current_user.properties.new(params[:property])
		respond_to do |format|
			if @property.save
				format.html { redirect_to(root_path, :notice => 'Property was successfully created.') }
				format.json { head :no_content }
			else
				format.html { render :action => "new" }
				format.json { render :json => @property.errors, :status => :unprocessable_entity }
			end
		end
  end	

  def destroy
		@property = Property.find(params[:id])
		if !@property.can_manage_property?(current_user) 
			respond_to do |format|
				format.html { render :nothing => true, :status => :forbidden }
				format.json  { render :nothing => true, :status => :forbidden }
			end
		else
			@property.destroy
			respond_to do |format|
				format.html { redirect_to(root_path, :notice => 'Property was successfully deleted.') }
				format.json { head :no_content }
			end
		end
  end

  def edit  	
		@property = Property.find(params[:id])
		if !@property.can_manage_property?(current_user) 
			respond_to do |format|
				format.html { render :nothing => true, :status => :forbidden }
				format.json  { render :nothing => true, :status => :forbidden }
			end
		end
  end

	def update
		@property = Property.find(params[:id])
		if @property.can_manage_property?(current_user)  
			respond_to do |format|
				if @property.update_attributes(params[:property])
					format.html { redirect_to(root_path, :notice => 'Property was successfully updated.') }
					format.json { head :no_content }
				else
					format.html { render :action => "edit" }
					format.json { render :json => @property.errors, :status => :unprocessable_entity }
				end
			end			
		else
			respond_to do |format|
				format.html { render :nothing => true, :status => :forbidden }
				format.json  { render :nothing => true, :status => :forbidden }
			end
		end
	end
  
end
