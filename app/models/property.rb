class Property < ActiveRecord::Base
  belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
  attr_accessible :approx_sqft, :bathrooms, :bedrooms, :city, :geo_lat, :geo_lon, :list_price, :street_name, :street_number, :street_suffix, :unit_number, :year_built, :zip_code
	validates :city, :street_name, :street_number, :owner, :presence => true
	
	geocoded_by :full_address, :latitude  => :geo_lat, :longitude => :geo_lon # ActiveRecord
	
	before_save :geocode

	def full_address
		[:unit_number, :street_number, :street_name, :street_suffix, :city, :zip_code].map{|m| self.send m }.join(" ")
		# self.zip_code + " " + self.city + " " + self.street_name + " " + self.street_suffix + " " + self.street_number + " " + self.unit_number
	end

	def owned_by?(user)
		owner == user
	end

	def belongs_to_friend?(user)
		user.friends.include?(owner)
	end

	def can_manage_property?(user)
		 owned_by?(user) || user.role == 'ADMIN'
	end
end
