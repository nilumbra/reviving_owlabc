class AddKindToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :kind, :string, :default => 'normal'
  end
end
