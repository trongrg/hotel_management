class RoomTypesController < InheritedResources::Base
  before_filter :authenticate_user!
  belongs_to :hotel
  load_and_authorize_resource
  before_filter :authorize_hotel

  protected
  def authorize_hotel
    authorize!(current_ability, @hotel)
  end

  def collection
    @room_types = @hotel.room_types.page(params[:page])
  end
end
