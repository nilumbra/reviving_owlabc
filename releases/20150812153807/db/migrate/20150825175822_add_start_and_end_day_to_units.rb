class AddStartAndEndDayToUnits < ActiveRecord::Migration
  def change
    add_column :units, :start_day, :date
    add_column :units, :end_day, :date
  end
end
