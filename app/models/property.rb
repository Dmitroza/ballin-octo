class Property < ActiveRecord::Base
  attr_accessible :approx_sqft, :bathrooms, :bedrooms, :city, :geo_lat, :geo_lon, :list_price, :street_name, :street_number, :street_suffix, :unit_number, :year_built, :zip_code
	validates :city, :street_name, :street_number, :presence => true
	def full_address
		@full_address = @full_address || self.zip_code + " " + self.city + " " + self.street_name + " " + self.street_suffix + " " + self.street_number + " " + self.unit_number
	end
end
