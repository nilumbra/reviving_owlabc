class Course < ActiveRecord::Base
  has_many :units
  serialize :standard, Hash

  LEVEL_SELECTION = ["1", "2", "3", "4", "5"]
  DURATION_SELECTION = Date::MONTHNAMES
  KIND_SELECTION = ['Normal', 'Test']

  scope :published, -> { where(published: true) }
  scope :has_submitted_units, -> { joins(units: :unit_evaluation) }

  amoeba do
    enable
  end

  def questions
    Question.where(:unit_id => self.units.collect{|u| u.id})
  end

  def clone_new
    course_copy = self.amoeba_dup
    course_copy.update_attributes(:title => self.title + '-copy', :published => false)
    course_copy.save
    course_copy
  end

  def standard_description
    arr = []
    from = 0
    self.standard.each do |key ,value|
      arr << "level #{key}: #{from} - #{value} question(s) correct."
      from = value
    end
    arr.join('<br/>')
  end

  def range_standard
    from = 0
    hash = {}
    self.standard.each do |key ,value|
      hash[from..value.to_i] = key
      from = value.to_i + 1
    end
    hash
  end

  def publish
    if self.kind == 'Test'
      Course.unscoped.where(kind: 'Test').each {|course| course.update_attributes(published: false)}
    end
    self.published = !self.published
    self.save
  end

  def all_units_submitted?(user)
    none_submitted_units = self.units.to_a.delete_if do |unit|
      ue = UnitEvaluation.find_by(unit: unit, user: user)
      ue && ue.submitted
    end
    none_submitted_units.empty?
  end
end
