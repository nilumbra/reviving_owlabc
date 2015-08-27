class AddExpectationToUnitEvaluations < ActiveRecord::Migration
  def change
    add_column :unit_evaluations, :expectation, :string
  end
end
