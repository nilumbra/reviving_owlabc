class AddFeedbackToHomework < ActiveRecord::Migration
  def change
    add_column :homeworks, :feedback, :text
    add_column :homeworks, :admin_id, :integer
  end
end
