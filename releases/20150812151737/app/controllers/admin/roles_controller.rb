class Admin::RolesController < Admin::BaseController
  authorize_resource
  
  def destroy
    if resource.admins.any?
      flash[:alert] = "Please cancel the roles in admins first!"
    else
      resource.destroy
      flash[:notice] = "The role was successfully destroyed."
    end
    respond_to do |format|
      format.html { redirect_to admin_roles_url }
      format.json { head :no_content }
    end
  end

  protected
  def collection
    @roles ||= end_of_association_chain.page(params[:page]).per(15)
  end

  private
  def resource_params
    params.require(:role).permit(:name, :title, permission_ids: [])
  end
end
