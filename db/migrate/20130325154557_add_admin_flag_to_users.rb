class AddAdminFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin_flag, :boolean, :null => false, :default => false
    admin = User.where(:email => "admin@example.com").first
    admin.update_attribute :admin_flag, true
  end
end
