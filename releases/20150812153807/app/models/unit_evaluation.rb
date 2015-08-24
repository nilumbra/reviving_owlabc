class UnitEvaluation < ActiveRecord::Base
  belongs_to :user
  belongs_to :unit

  scope :evaluation_report, -> { joins(unit: :course).where.not(score: nil).pluck("courses.title", "units.title", :score, :finish_time, :start_time ) }
end
