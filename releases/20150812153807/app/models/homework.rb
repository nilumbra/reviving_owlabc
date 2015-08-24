class Homework < ActiveRecord::Base
  serialize :answer, Array
  belongs_to :user
  belongs_to :question
  belongs_to :admin

  scope :submitted_for_review, -> { joins(question: {unit: :unit_evaluation})
                                    .where('questions.kind = ? and unit_evaluations.submitted = ?', 'Question', true)
                                  }
  scope :need_feedback, -> { joins(:question).where('homeworks.feedback is null and questions.kind = ?', 'Question') }
  scope :has_feedback, -> { joins(:question).where('homeworks.feedback is not null and questions.kind = ?', 'Question') }

  scope :submitted_for_judge, -> { joins(question: {unit: :unit_evaluation})
                                    .where('questions.kind <> ? and unit_evaluations.submitted = ?', 'Question', true)
                                  }
  scope :need_jedge, -> { joins(:question).where('homeworks.feedback is null and questions.kind <> ?', 'Question') }

  def course_name
    self.question.unit.course.title
  end

  def username
    self.user.display_name
  end

  def unit_title
    self.question.unit.title
  end

  def question_title
    self.question.content
  end

  def support_basic_operation
    false
  end

  def lock
    self.expires = Time.now.in_time_zone + 10.minutes
    self.save
  end

  def locked?
    if self.expires.nil?
      false
    elsif self.expires - Time.now.in_time_zone > 0
      true
    elsif self.expires - Time.now.in_time_zone < 0
      false
    end
  end
end
