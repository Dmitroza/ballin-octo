class CrudController < ApplicationController
  def index
  	@properties = Property.all
  end
end
