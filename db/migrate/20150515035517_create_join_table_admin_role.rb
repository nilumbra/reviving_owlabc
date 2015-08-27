class CreateJoinTableAdminRole < ActiveRecord::Migration
  def change
    create_join_table :admins, :roles do |t|
    end
  end
end
