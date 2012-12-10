class HotelsController < InheritedResources::Base
  responders :flash, :http_cache
  before_filter :authenticate_user!
  respond_to :html
  load_and_authorize_resource

  def create
    @hotel = Hotel.new(params[:hotel])
    @hotel.owners << current_user
    create!
  end

  protected
  def collection
    @hotels = current_user.hotels.page(params[:page])
  end
end
