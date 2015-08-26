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

  # Units which are going to be display per week on the calendar
  def unit_events
   course = current_user.current_course
   counter_start = 0
   counter_end = 5
   first_chapter = 1 
   @units = []
   
   title_string = "Read " + "Unit "
   chapters_string = " (chapters "

   course.units.each do |unit|
      start_date = date_of_next("Monday", unit.course.duration.to_date)
      @units << { title: title_string + unit.title + chapters_string + first_chapter.to_s + "~ " + unit.questions.count.to_s + ")", 
                  start: start_date + counter_start, 
                  :end => start_date + counter_end }
      counter_start += 7
      counter_end = counter_start + 5
      first_chapter = unit.questions.count + 1
   end
      render json: @units.to_json 
  end

  def homework_events
    
  end

  # Date of next Monday
  def date_of_next(day, in_month)
    wday  = in_month.wday
    if wday > 4
      in_month + (8 - wday) # next monday
    end
  end
end