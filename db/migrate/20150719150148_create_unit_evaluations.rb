class CreateUnitEvaluations < ActiveRecord::Migration
  def change
    create_table :unit_evaluations do |t|
      t.integer :score
      t.references :user, index: true
      t.references :unit, index: true
      t.datetime :start_time
      t.datetime :finish_time
      t.time :duration
      t.boolean :submitted

      t.timestamps null: false
    end
    add_foreign_key :unit_evaluations, :users
    add_foreign_key :unit_evaluations, :units
  end
end
