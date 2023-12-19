class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :integer, default: 1
    add_column :users, :provider_id, :string
    add_column :users, :status, :integer, default: 0
  end
end
