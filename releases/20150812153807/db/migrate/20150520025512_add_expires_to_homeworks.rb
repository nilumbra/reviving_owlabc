class AddExpiresToHomeworks < ActiveRecord::Migration
  def change
    add_column :homeworks, :expires, :datetime
  end
end
