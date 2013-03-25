class Property < ActiveRecord::Base
  belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
  attr_accessible :approx_sqft, :bathrooms, :bedrooms, :city, :geo_lat, :geo_lon, :list_price, :street_name, :street_number, :street_suffix, :unit_number, :year_built, :zip_code
	validates :city, :street_name, :street_number, :owner, :presence => true
	def full_address
		[:zip_code, :city, :street_name, :street_suffix, :street_number, :unit_number].map{|m| self.send m }.join(" ")
		# self.zip_code + " " + self.city + " " + self.street_name + " " + self.street_suffix + " " + self.street_number + " " + self.unit_number
	end
end
