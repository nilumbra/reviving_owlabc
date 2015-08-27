class Admin::UnitsController < Admin::BaseController
  authorize_resource
  belongs_to :course, :parent_class => Course

  protected
  def collection
    @units ||= end_of_association_chain.page(params[:page]).per(15)
  end
  
  private
  def resource_params
    params.require(:unit).permit(:title, :pdf)
  end
end
