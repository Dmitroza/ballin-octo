class AddAdminFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin_flag, :boolean, :null => false, :default => false
    admin = User.new(:email => "admin@example.com", :password => "12345678", :password_confirmation => "12345678")
    admin.save
    admin.update_attribute :admin_flag, true
  end
end
