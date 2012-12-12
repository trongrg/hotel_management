class HotelsController < InheritedResources::Base
  responders :flash, :http_cache
  before_filter :authenticate_user!
  respond_to :html
  respond_to :json, :only => :create
  load_and_authorize_resource

  layout :determine_layout

  def create
    @hotel = Hotel.new(params[:hotel])
    @hotel.owners << current_user
    create!
  end

  protected
  def collection
    @hotels = current_user.hotels.page(params[:page])
  end

  def determine_layout
    if request.xhr?
      false
    else
      'application'
    end
  end
end
