class AddRealNameToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :real_name, :string
  end
end
