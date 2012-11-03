class ReservationsController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!
  before_filter :load_room
  before_filter :load_currencies

  load_and_authorize_resource

  expose(:reservation)

  # GET /reservations
  # GET /reservations.json
  def index
    if Reservation::STATUS.stringify_keys.keys.include?(params[:status])
      @reservations = @room.reservations.send(params[:status])
    else
      @reservations = @room.reservations
    end
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  # GET /reservations/new.json
  def new
  end

  # GET /reservations/1/edit
  def edit
    if @reservation.expired?
      redirect_to room_reservations_path(@room), notice: "Cannot edit/delete expired reservation"
    end
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation.user = current_user

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to room_reservations_url(@room), notice: t('record.created', :record => t('model.reservation')) }
        format.json { render json: @reservation, status: :created, location: @reservation }
      else
        format.html { render action: "new" }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reservations/1
  # PUT /reservations/1.json
  def update
    @reservation.user = current_user
    respond_to do |format|
      if @reservation.update_attributes(params[:reservation])
        format.html { redirect_to room_reservation_url(@room, @reservation), notice: t('record.updated', :record => t('model.reservation')) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to room_reservations_url(@room), notice: t('record.deleted', :record => t('model.reservation')) }
      format.json { head :no_content }
    end
  end
end
