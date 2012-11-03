class RoomsController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!
  before_filter :load_hotel

  load_and_authorize_resource

  expose(:room)

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = @hotel.rooms.page(params[:page])
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
  end

  # GET /rooms/new
  # GET /rooms/new.json
  def new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
  def create
    create_response @room.save, @room, "created", "new"
  end

  # PUT /rooms/1
  # PUT /rooms/1.json
  def update
    create_response @room.update_attributes(params[:room]), @room, "updated", "edit"
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    create_response @room.destroy, @room, "deleted", "show"
  end
end
