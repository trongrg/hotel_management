class CheckInsController < InheritedResources::Base
  belongs_to :hotel

  before_filter :authenticate_user!
  load_and_authorize_resource
  before_filter :authorize_hotel

  protected
  def collection
    @check_ins = @hotel.check_ins.status(params[:status]).page(params[:page])
  end
end
