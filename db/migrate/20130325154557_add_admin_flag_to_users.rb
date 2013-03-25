class AddAdminFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin_flag, :boolean, :null => false, :default => false
    User.where(:email => "admin@example.com").first.admin_flag = true
  end
end
