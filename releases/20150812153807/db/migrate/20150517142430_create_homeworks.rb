class CreateHomeworks < ActiveRecord::Migration
  def change
    create_table :homeworks do |t|
      t.integer :question_id
      t.integer :user_id
      t.text :answer
      t.string :choice_ids
      t.timestamps
    end
  end
end
