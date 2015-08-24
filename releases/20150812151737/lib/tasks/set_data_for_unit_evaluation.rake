require 'active_record'

desc 'generate the UnitEvaluation data from existed database'
namespace :fix do
  task set_data: :environment do
    User.all.each do |user|
      Unit.all.each do |unit|
        next if unit.questions.empty?
        set_data user, unit
      end
    end
  end
end

def set_data(user, unit)
  first_homework_in_unit = Homework.find_by user: user, question: unit.questions.first
  all_homeworks_in_unit  = Homework.where user: user, question: unit.questions

  unit_evaluation = nil
  # user started the unit
  if first_homework_in_unit.present?
    unit_evaluation = UnitEvaluation.create user: user, unit: unit, start_time: first_homework_in_unit.created_at
  end
  # user finished the unit
  if all_homeworks_in_unit.size == unit.questions.size
    finish_time = all_homeworks_in_unit.last.created_at
    duration = Time.at(finish_time - unit_evaluation.start_time).utc.strftime("%H:%M:%S")
    unit_evaluation.update finish_time: finish_time, duration: duration, submitted: true

    judge_mcq_homeworks user, unit_evaluation
  end
end

def judge_mcq_homeworks user, unit_evaluation
  # judge
  Homework.where(user: user).submitted_for_judge.need_jedge.each do |homework|
    right_answer_ids = Choice.where(question: homework.question, is_correct: true).pluck :id
    homework.update feedback: homework.answer.map(&:to_i) == right_answer_ids ? 'true' : 'false'
  end
  # evaluate
  unit_mcqs = unit_evaluation.unit.questions.where("kind <> ?", 'Question')
  right_answers = Homework.where user: user, question: unit_mcqs, feedback: 'true'
  unit_evaluation.update(score: right_answers.size / unit_mcqs.size.to_f * 100) unless unit_mcqs.size.zero?

  case unit_evaluation.score
  when nil
    expectation = 'None'
  when 0..25
    expectation = 'Below'
  when 26..85
    expectation = 'Meet'
  else
    expectation = 'Exceed'
  end
  unit_evaluation.update expectation: expectation
end
