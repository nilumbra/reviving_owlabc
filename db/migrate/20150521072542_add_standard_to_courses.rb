class AddStandardToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :standard, :string
  end
end
