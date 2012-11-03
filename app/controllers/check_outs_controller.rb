class CheckOutsController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!
  before_filter :load_room
  before_filter :load_currencies

  load_and_authorize_resource

  expose(:check_out)

  before_filter :check_room_occupation, :except => :index

  # GET /check_outs
  # GET /check_outs.json
  def index
    @room.check_outs.page(params[:page])
  end

  # GET /check_outs/1
  # GET /check_outs/1.json
  def show
  end

  # GET /check_outs/new
  # GET /check_outs/new.json
  def new
  end

  # GET /check_outs/1/edit
  def edit
  end

  # POST /check_outs
  # POST /check_outs.json
  def create
    @check_out.room = @room
    @check_out.user = current_user
    create_response @check_out.save, @check_out, "created", "new"
  end

  # PUT /check_outs/1
  # PUT /check_outs/1.json
  def update
    @check_out.user = current_user
    create_response @check_out.update_attributes(params[:check_out]), @check_out, "updated", "edit"
  end

  # DELETE /check_outs/1
  # DELETE /check_outs/1.json
  def destroy
    create_response @check_out.destroy, @check_out, "deleted", "show"
  end

  private
  def check_room_occupation
    redirect_to room_check_outs_url(@room), alert: "Cannot create check out of unoccupied room" unless @room.occupied?
  end
end
