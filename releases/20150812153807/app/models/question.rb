class Question < ActiveRecord::Base
  belongs_to :unit
  amoeba do
    enable
  end
  has_many :choices
  accepts_nested_attributes_for :choices, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  CHOICE_COUNT_MIN = 1
  validate :must_have_one_choice
  validate :must_have_one_correct_choice

  def must_have_one_choice
    errors.add(:choices, 'must have one choice and must have one correct choice.') if choices_empty?
  end

  def must_have_one_correct_choice
    errors.add(:choices, 'must have one correct choice.') if correct_choices_empty?
  end

  def choices_empty?
    kind == 'MCQ' and choices.empty?
  end

  def correct_choices_empty?
    kind == 'MCQ' and choices.select{|choice| choice.is_correct }.length == 0
  end

  validates :content, :kind, presence: true

  QUESTION_TYPE = ["MCQ", "Question"]
  after_save :delete_choices_if_question

  has_many :homeworks


  def choices_content
    self.choices.collect do |c| 
      mark = c.is_correct ? '<i class="checkmark icon"></i> ' : '<i class="remove icon"></i> '
      mark + c.content
    end.join('<br/>')
  end

  def correct_choices
    self.choices.where('is_correct is true')
  end

  def delete_choices_if_question
    self.choices.delete_all if self.kind == 'Question'
  end
end
