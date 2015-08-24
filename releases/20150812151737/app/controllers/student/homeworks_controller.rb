class Student::HomeworksController < Student::BaseController
  before_filter :detect_student_paid_status

  def index
    @homeworks = current_user.homeworks
  end

  def answer_question
    unless current_user.finish_current_unit?
      unit_evaluation = UnitEvaluation.create_with(start_time: Time.now).find_or_create_by(user: current_user, unit: current_user.current_unit)
      @question = current_user.next_question
    else
      @question = nil
    end
  end

  def create
    @homework = current_user.homeworks.new(homework_params)
    respond_to do |format|
      if @homework.save
        if current_user.current_course.kind == 'Test' and current_user.profile.level == 'None' and current_user.next_question.nil?
          current_user.cal_level
          format.html{ redirect_to '/student/level', :notice => 'Congratulations, You are at level' + current_user.profile.level }
        else
          format.html{ redirect_to answer_question_student_homeworks_path }
        end

      else
        format.html{ render :answer_question}
      end
    end
  end

  def submit
    return(head :bad_request) unless params[:homework_id]
    unit_evaluation = UnitEvaluation.find_or_create_by user: current_user, unit: Unit.find(params[:homework_id])
    finish_time = Time.now
    duration = Time.at(finish_time - unit_evaluation.start_time).utc.strftime("%H:%M:%S")
    unit_evaluation.update(finish_time: finish_time, duration: duration, submitted: true)

    judge_mcq_homeworks unit_evaluation
    head :ok
  end

  protected
  def homework_params
    params.require(:homework).permit(:question_id, :answer => [])
  end

  def judge_mcq_homeworks unit_evaluation
    # judge
    Homework.where(user: current_user).submitted_for_judge.need_jedge.each do |homework|
      right_answer_ids = Choice.where(question: homework.question, is_correct: true).pluck :id
      homework.update feedback: homework.answer.map(&:to_i) == right_answer_ids ? 'true' : 'false'
    end
    # evaluate
    unit_mcqs = unit_evaluation.unit.questions.where("kind <> ?", 'Question')
    right_answers = Homework.where user: current_user, question: unit_mcqs, feedback: 'true'
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
end
