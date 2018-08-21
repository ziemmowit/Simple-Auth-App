class SetRoleDefaultToZero < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :role, :integer, :default => "0", :null => "false"
  end
  def up
    change_column :users, :role, :integer, :default => "false"
  end
end
