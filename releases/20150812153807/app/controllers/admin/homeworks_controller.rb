class Admin::HomeworksController < Admin::BaseController
  authorize_resource
  actions :all, :except => [:new, :destroy, :create]

  def index
    if params[:scope] == 'sent'
      @homeworks = Homework.submitted_for_review.has_feedback.uniq.order('homeworks.user_id DESC')
    else
      @homeworks = Homework.submitted_for_review.need_feedback.uniq.order('homeworks.user_id DESC')
    end
    @homeworks = @homeworks.page(params[:page]).per(15)
  end

  def edit
    @homework = Homework.find(params[:id])
    if @homework.locked?
      redirect_to collection_path(:notice => 'Homework is locked.')
    else
      @homework.lock
    end
  end

  def update
    update!(:notice => "Feedback sent successfully.") do |format|
      if resource.errors.empty?
        resource.admin = current_admin
        resource.save
      end
    end
  end

  protected
  def collection
    @homeworks ||= end_of_association_chain.page(params[:page]).per(15)
  end


  private
  def resource_params
    params.require(:homework).permit(:feedback)
  end
end
