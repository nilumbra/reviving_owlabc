class Student::PagesController < Student::BaseController
  before_filter :detect_student_paid_status, :only => [:index]
  before_filter :detect_current_course, :only => [:index]
  def index
    @profile = current_user.profile
  end

  def level
    @profile = current_user.profile
  end
  
  def unpaid
    if user_signed_in? && current_user.paid?
      redirect_to student_root_path
    end
  end

  def hold_on;end
end