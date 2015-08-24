class Admin::PermissionsController < Admin::BaseController
  authorize_resource
  
  def destroy
    if @permission.roles.any?
      flash[:alert] = "Please cancel the permissions in roles first!"
    else
      @permission.destroy
      flash[:notice] = "权限已成功删除"
    end
    respond_to do |format|
      format.html { redirect_to admin_permissions_url }
      format.json { head :no_content }
    end
  end

  protected
  def collection
    @permissions ||= end_of_association_chain.page(params[:page]).per(15)
  end

  private
  def resource_params
    params.require(:permission).permit(:action, :subject, :description)
  end
end
