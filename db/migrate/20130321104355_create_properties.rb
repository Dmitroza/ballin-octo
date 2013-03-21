class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :zip_code
      t.string :city
      t.string :street_name
      t.string :street_suffix
      t.string :street_number
      t.string :unit_number
      t.float :geo_lon 
      t.float :geo_lat
      t.integer :year_built
      t.integer :bedrooms
      t.integer :bathrooms
      t.float :approx_sqft
      t.float :list_price

      t.timestamps
    end
  end
end
