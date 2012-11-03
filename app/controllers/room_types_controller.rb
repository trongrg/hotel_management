class RoomTypesController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!
  before_filter :load_hotel
  before_filter :load_currencies

  load_and_authorize_resource

  expose(:room_type)

  # GET /room_types
  # GET /room_types.json
  def index
    @room_types = @hotel.room_types.page(params[:page])
  end

  # GET /room_types/1
  # GET /room_types/1.json
  def show
  end

  # GET /room_types/new
  # GET /room_types/new.json
  def new
  end

  # GET /room_types/1/edit
  def edit
  end

  # POST /room_types
  # POST /room_types.json
  def create
    @room_type.hotel = @hotel
    create_response @room_type.save, @room_type, "created", "new"
  end

  # PUT /room_types/1
  # PUT /room_types/1.json
  def update
    create_response @room_type.update_attributes(params[:room_type]), @room_type, "updated", "edit"
  end

  # DELETE /room_types/1
  # DELETE /room_types/1.json
  def destroy
    create_response @room_type.destroy, @room_type, "deleted", "show"
  end
end
