class RemoveChoiceIdsFromHomeworks < ActiveRecord::Migration
  def change
    Homework.all.each do |homework|
      homework.update answer: YAML::load(homework.choice_ids) unless YAML::load(homework.choice_ids).empty?
    end
    remove_column :homeworks, :choice_ids, :string
  end
end
