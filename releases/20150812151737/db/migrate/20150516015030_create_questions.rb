class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :unit_id
      t.string  :kind
      t.text    :content
      t.timestamps
    end
  end
end
