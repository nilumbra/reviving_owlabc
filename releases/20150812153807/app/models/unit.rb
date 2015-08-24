class Unit < ActiveRecord::Base
  belongs_to :course
  amoeba do
    enable
  end
  has_many :questions
  has_one  :unit_evaluation
  has_attached_file :pdf
  validates_attachment_content_type :pdf, :content_type => "application/pdf"

  def question_index(question)
    "#{questions.to_a.index(question) + 1} / #{questions.length}"
  end
end
