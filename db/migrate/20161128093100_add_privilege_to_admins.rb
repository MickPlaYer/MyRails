class AddPrivilegeToAdmins < ActiveRecord::Migration[5.0]
  def change
    add_column :admins, :privilege, :boolean, default: false
  end
end
