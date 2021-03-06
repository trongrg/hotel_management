class ApplicationController < ActionController::Base

  def delayed_job_admin_authentication
    # authentication_logic_goes_here
    true
  end

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to root_path
  end

  protected
  def authorize_hotel
    authorize!(:read, @hotel)
  end
end
