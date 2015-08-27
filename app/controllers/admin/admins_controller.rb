class Admin::AdminsController < Admin::BaseController
  
  authorize_resource except: [:update_password, :edit_password]

  def update_password
    respond_to do |format|
      if current_admin.update(resource_params)
        format.html { redirect_to admin_root_path, notice: 'Your password was changed successfully.' }
      else
        format.html { render :edit_password }
      end
    end
  end

  protected
  def collection
    @admins ||= end_of_association_chain.page(params[:page]).per(15)
  end


  private
  def resource_params
    params.require(:admin).permit(:username, :email, :password, :password_confrimation, role_ids: [])
  end
end
