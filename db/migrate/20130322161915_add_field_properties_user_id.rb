class AddFieldPropertiesUserId < ActiveRecord::Migration
  def up
  	add_column :properties, :user_id, :integer
  	admin = User.create(:email => "admin@example.com")
  	Property.update_all :user_id => admin.id

  	#Property.all.each { |p| p.user = admin }
  end

  def down
  	remove_column :properties, :user_id
  	User.where(:email => "admin@example.com").destroy
  end
end
