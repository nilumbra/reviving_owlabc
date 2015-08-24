class Student::FeedbacksController < Student::BaseController
  before_filter :detect_student_paid_status

  def index
    @joined_courses = current_user.joined_courses.uniq
  end

  def show
    @question = Question.find(params[:id])
    @feedback = current_user.homeworks.find_by_question_id(params[:id])
  end
end
