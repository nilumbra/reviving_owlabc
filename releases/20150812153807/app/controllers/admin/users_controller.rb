class Admin::UsersController < Admin::BaseController

  authorize_resource
  custom_actions :collection => :batch_operation

  def index
    index! do |format|
      format.xls {
        @users = User.all
      }
    end
  end

  def switch_payment_status
    resource.switch_payment_status
  end

  def batch_operation
    respond_to do |format|
      if params[:commit] == 'Batch Delete'
        @users = User.where( :id => params[:user_ids])
        @users.delete_all
        format.html { redirect_to collection_path, :notice => 'Students were successfully destroyed.' }
      end
    end
  end

  def homework_report
    @reports = resource.unit_evaluations.evaluation_report
  end

  protected
  def collection
    @users ||= end_of_association_chain.page(params[:page]).per(15)
  end


  private
  def resource_params
    params.require(:user).permit(:username, :email, :password, :password_confrimation)
  end
end
