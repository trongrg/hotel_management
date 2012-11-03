class CheckInsController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!
  before_filter :load_room
  before_filter :load_currencies

  load_and_authorize_resource

  expose(:check_in)

  # GET /check_ins
  # GET /check_ins.json
  def index
    @check_ins = @room.check_ins.with_status(params[:status]).page(params[:page])
  end

  # GET /check_ins/1
  # GET /check_ins/1.json
  def show
  end

  # GET /check_ins/new
  # GET /check_ins/new.json
  def new
  end

  # GET /check_ins/1/edit
  def edit
  end

  # POST /check_ins
  # POST /check_ins.json
  def create
    @check_in.user = current_user
    @check_in.room = @room
    create_response @check_in.save, @check_in, "created", "new"
  end

  # PUT /check_ins/1
  # PUT /check_ins/1.json
  def update
    @check_in.user = current_user
    create_response @check_in.update_attributes(params[:check_in]), @check_in, "updated", "edit"
  end

  # DELETE /check_ins/1
  # DELETE /check_ins/1.json
  def destroy
    create_response @check_in.destroy, @check_in, "deleted", "show"
  end
end
