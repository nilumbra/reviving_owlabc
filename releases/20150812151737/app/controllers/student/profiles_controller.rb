class Student::ProfilesController < Student::BaseController
  
  def show
    @profile = current_user.profile
  end

  def update
    respond_to do |format|
      @profile = current_user.profile
      if @profile.update(profile_params)
        format.html{ redirect_to student_profile_path, notice: 'Profile was successfully updated.'}
      else
        format.html { render :show}
      end
    end
  end

  def upload_avatar
    @profile = current_user.profile
    @profile.update(:avatar => params[:profile][:avatar])
  end

  protected
  def profile_params
    params.require(:profile).permit(:avatar, :phone, :wechat, :qq, :real_name, :address, :zip_code)
  end
end
