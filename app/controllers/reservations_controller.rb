class ReservationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_room
  load_and_authorize_resource
  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reservations }
    end
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
    @reservation = Reservation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reservation }
    end
  end

  # GET /reservations/new
  # GET /reservations/new.json
  def new
    @reservation = Reservation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reservation }
    end
  end

  # GET /reservations/1/edit
  def edit
    @reservation = Reservation.find(params[:id])
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = @room.reservations.new(params[:reservation])
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
    @reservation = Reservation.find(params[:id])

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
    @reservation = Reservation.find(params[:id])
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to room_reservations_url(@room), notice: t('record.deleted', :record => t('model.reservation')) }
      format.json { head :no_content }
    end
  end
  private
  def load_room
    @room = Room.find params[:room_id]
  end
end
