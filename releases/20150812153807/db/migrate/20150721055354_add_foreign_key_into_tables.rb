class AddForeignKeyIntoTables < ActiveRecord::Migration
  def change
    add_foreign_key :units, :courses, name: :index_units_on_course_id
    add_foreign_key :questions, :units, name: :index_questions_on_unit_id
    add_foreign_key :choices, :questions, name: :index_choices_on_question_id
    add_foreign_key :homeworks, :questions, name: :index_homeworks_on_question_id
    add_foreign_key :homeworks, :users, name: :index_homeworks_on_user_id
  end
end
