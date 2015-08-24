class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.string :level
      t.string :duration
      t.timestamps
    end
  end
end
