class RoomTypesController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!
  before_filter :load_hotel
  before_filter :load_currencies

  load_and_authorize_resource

  expose(:room_types) { @hotel.room_types.page(params[:page]) }
  expose(:room_type)

  # GET /room_types
  # GET /room_types.json
  def index
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

    respond_to do |format|
      if @room_type.save
        format.html { redirect_to hotel_room_type_path(@hotel, @room_type), notice: t('record.created', :record => t('model.room_type')) }
        format.json { render json: @room_type, status: :created, location: @room_type }
      else
        format.html { render action: "new" }
        format.json { render json: @room_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /room_types/1
  # PUT /room_types/1.json
  def update
    respond_to do |format|
      if @room_type.update_attributes(params[:room_type])
        format.html { redirect_to hotel_room_type_path(@hotel, @room_type), notice: t('record.updated', :record => t('model.room_type')) }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @room_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /room_types/1
  # DELETE /room_types/1.json
  def destroy
    @room_type.destroy

    respond_to do |format|
      format.html { redirect_to hotel_room_types_url, :notice => t('record.deleted', :record => t('model.room_type')) }
      format.json { head :ok }
    end
  end
  protected
  def load_hotel
    @hotel = Hotel.find(params[:hotel_id])
    authorize! :read, @hotel
  end
end
