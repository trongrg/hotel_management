class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :mailer_set_url_options

  protected
  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_path
  end

  def after_sign_out_path(resource)
    stored_location_for(resource) || dashboard_path
  end

  def load_currencies
    @currencies = Money::Currency::table.values.inject({}) do |hash, currency|
      hash.update(currency[:iso_code] => currency[:iso_code])
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to dashboard_path
  end
end
