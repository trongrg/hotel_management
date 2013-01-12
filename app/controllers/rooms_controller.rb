class RoomsController < InheritedResources::Base
  belongs_to :hotel

  before_filter :authenticate_user!
  load_and_authorize_resource
  before_filter :authorize_hotel

  protected
  def collection
    @rooms = @hotel.rooms.page(params[:page])
  end
  private
  def authorize_hotel
    authorize!(current_ability, @hotel)
  end
end
