class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_path
  end

  def after_sign_out_path(resource)
    stored_location_for(resource) || dashboard_path
  end
end
