class Admin::QuestionsController < Admin::BaseController
  authorize_resource
  belongs_to :unit, :parent_class => Unit

  def new
    @unit = Unit.find(params[:unit_id])
    @question = @unit.questions.new
    4.times { @question.choices.build }
    new!
  end

  protected
  def collection
    @questions ||= end_of_association_chain.page(params[:page]).per(15)
  end
  
  private
  def resource_params
    params.require(:question).permit(:kind, :content, choices_attributes: [:id, :content, :is_correct, :_destroy])
  end
end
