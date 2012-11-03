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
    @reservations = @room.reservations.with_status(params[:status]).page(params[:page])
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
    redirect_to room_reservations_path(@room), alert: "Cannot edit/delete expired reservation" if @reservation.expired?
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation.user = current_user
    @reservation.room = @room
    create_response @reservation.save, @reservation, "created", "new"
  end

  # PUT /reservations/1
  # PUT /reservations/1.json
  def update
    @reservation.user = current_user
    create_response @reservation.update_attributes(params[:reservation]), @reservation, "updated", "edit"
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    create_response @reservation.destroy, @reservation, "deleted", "show"
  end
end
