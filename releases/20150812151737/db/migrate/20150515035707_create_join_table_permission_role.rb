class CreateJoinTablePermissionRole < ActiveRecord::Migration
  def change
    create_join_table :permissions, :roles do |t|
    end
  end
end
