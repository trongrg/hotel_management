class FurnishingsController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!
  before_filter :load_room_type
  before_filter :load_currencies

  load_and_authorize_resource

  expose(:furnishing)

  # GET /furnishings
  # GET /furnishings.json
  def index
    @furnishings = @room_type.furnishings.page(params[:page])
  end

  # GET /furnishings/1
  # GET /furnishings/1.json
  def show
  end

  # GET /furnishings/new
  # GET /furnishings/new.json
  def new
  end

  # GET /furnishings/1/edit
  def edit
  end

  # POST /furnishings
  # POST /furnishings.json
  def create
    @furnishing.room_type = @room_type
    create_response @furnishing.save, @furnishing, "created", "new"
  end

  # PUT /furnishings/1
  # PUT /furnishings/1.json
  def update
    create_response @furnishing.update_attributes(params[:furnishing]), @furnishing, "updated", "edit"
  end

  # DELETE /furnishings/1
  # DELETE /furnishings/1.json
  def destroy
    create_response @furnishing.destroy, @furnishing, "deleted", "show"
  end

  private
  def load_room_type
    @room_type = RoomType.find(params[:room_type_id])
  end
end
