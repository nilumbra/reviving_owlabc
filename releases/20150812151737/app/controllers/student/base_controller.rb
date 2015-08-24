class Student::BaseController < ApplicationController
  before_filter :authenticate_user!

  def detect_student_paid_status
    if user_signed_in? and current_user.payment_status == 'unpaid'
      redirect_to '/student/unpaid'
    end
  end

  def detect_current_course
    if current_user.current_course.nil?
      redirect_to '/student/hold_on'
    end
  end
end
