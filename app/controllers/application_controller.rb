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

  def load_room
    @room = Room.find(params[:room_id])
    authorize! :read, @room
  end

  def load_hotel
    @hotel = Hotel.find(params[:hotel_id])
    authorize! :read, @hotel
  end

  def create_response(success, object, message, action)
    respond_to do |format|
      if success
        notice = t("record.#{message}", :record => t("model.#{object.class.name.downcase}"))
        format.html do
          flash[:notice] = notice
          redirect_to action: :index
        end
        format.json { render json: { result: object, notice: notice, status: :success } }
      else
        format.html do
          flash[:alert] = object.errors.full_messages.join("<br/>").html_safe
          if message == "deleted"
            redirect_to action: :index
          else
            render action: action
          end
        end
        format.json { render json: object.errors, status: :unprocessable_entity }
      end
    end
  end
end
