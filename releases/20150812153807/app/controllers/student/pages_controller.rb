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
   @units = []
   course.units.each do |unit|
      start_date = date_of_next("Monday", unit.course.duration.to_date)
      @units << { title: unit.title, start: start_date + counter_start, 
                  :end => start_date + counter_end }
      counter_start += 7
      counter_end = counter_start + 5
   end
      render json: @units.to_json 
  end

  # Date of next Monday
  def date_of_next(day, in_month)
    wday  = in_month.wday
    if wday > 4
      in_month + (8 - wday) # next monday
    end
  end

end




 # def unit_events
 #    # respond_to :json
 #    # p '++++++++++++++++++++', 
 #    course = current_user.current_course
 #    counter = 7
 #    first_u = course.units.first
 #    @units = {}
 #    course.units.each do |unit|
 #      start_date = date_of_next("Monday", unit.course.duration.to_date)
 #      @units = {id: unit.id, first_start: start_date, second_start: start_date + counter, 
 #        third_start: start_date + 2*counter, fourth_start: start_date + 3*counter}
 #    end
 #    p '****************', @units
 #    # @units = Unit.between(params['start'], params['end']) if (params['start'] && params['end'])

 #    respond_to do |format|
 #      format.html # index.html.erb
 #      format.json { render json: @units }
 #    end
 #  end