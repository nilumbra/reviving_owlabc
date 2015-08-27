class Admin::BaseController < ApplicationController
  layout "admin"
  before_filter :authenticate_admin!
  inherit_resources
  defaults :route_prefix => 'admin'

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html {redirect_to admin_root_url, :alert => exception.message}
      # format.js { render :template =>'/share/msg',:locals=>{:alert_msg=> exception.message} }
    end
  end

  private
  def current_user
    current_admin
  end
  
  def signed_in?
    !!current_user
  end

  def login_required
    signed_in? || access_denied
  end

  def access_denied
    respond_to do |format|
      format.html do
        redirect_to login_path
      end
      format.any(:json, :xml) do
        request_http_basic_authentication 'Web Password'
      end
    end
  end
end