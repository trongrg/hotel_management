class ApplicationController < ActionController::Base

def delayed_job_admin_authentication
  # authentication_logic_goes_here
  true
end

  protect_from_forgery
end
