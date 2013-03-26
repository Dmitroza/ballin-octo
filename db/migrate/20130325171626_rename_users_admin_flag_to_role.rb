class RenameUsersAdminFlagToRole < ActiveRecord::Migration
  def up
  	rename_column :users, :admin_flag, :role
  	change_column :users, :role, :string
  	User.where(:email => "admin@example.com").first.update_attribute :role, 'ADMIN'
  end

  def down
  	rename_column :users, :role, :admin_flag
  	change_column :users, :admin_flag, :boolean
  	User.where(:email => "admin@example.com").first.update_attribute :role, true
  end
end
