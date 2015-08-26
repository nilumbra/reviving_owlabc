class Unit < ActiveRecord::Base
  belongs_to :course
  has_many :questions
  has_one  :unit_evaluation
  has_attached_file :pdf
  validates_attachment_content_type :pdf, :content_type => "application/pdf"

  amoeba do
    enable
  end
  
  def question_index(question)
    "#{questions.to_a.index(question) + 1} / #{questions.length}"
  end
end
