2class RenameUsersAdminFlagToRole < ActiveRecord::Migration
  def up
  	rename_column :users, :admin_flag, :role
  	change_column :users, :role, :string, :default => 'REGUSER'
  	admin = User.where(:email => "admin@example.com").first
    admin.update_attribute :role, 'ADMIN'
  end

  def down
  	rename_column :users, :role, :admin_flag
  	change_column :users, :admin_flag, :boolean, :default => false
  	admin = User.where(:email => "admin@example.com").first
    admin.update_attribute :role, true
  end
end
