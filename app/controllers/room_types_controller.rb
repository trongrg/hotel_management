class RoomTypesController < InheritedResources::Base
  belongs_to :hotel
  before_filter :authenticate_user!
  load_and_authorize_resource
  before_filter :authorize_hotel

  protected
  def collection
    @room_types = @hotel.room_types.page(params[:page])
  end
end
