class Admin::CoursesController < Admin::BaseController
  authorize_resource

  def create
    if params[:course][:kind] == 'Test'
      params[:course].except(:level, :duration)
      create!(:notice => "Test course was successfully created.") {
        unit = resource.units.create(:title => resource.title)
        new_admin_unit_question_path(unit)
      }
    else
      create!(:notice => "Course was successfully created.") { new_admin_course_unit_path(resource) }
    end
  end

  def publish
    resource.publish
  end

  def clone
    @new_course = resource.clone_new
    redirect_to admin_course_path(@new_course), :notice => 'Course was successfully duplicated.'
  end

  protected

  def collection
    @courses ||= end_of_association_chain.unscoped.page(params[:page]).per(15)
  end


  private
  def resource_params
    params.require(:course).permit(:title, :kind, :level, :duration).tap do |while_listed|
      while_listed[:standard] = params[:course][:standard]
    end
  end
end
