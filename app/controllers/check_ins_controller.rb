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
    @check_ins = if CheckIn::STATUS.stringify_keys.keys.include?(params[:status])
      @room.check_ins.send(params[:status])
    else
      @room.check_ins
    end
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
    respond_to do |format|
      if @check_in.save
        format.html { redirect_to room_check_in_url(@room, @check_in), notice: t('record.created', :record => t('model.check_in')) }
        format.json { render json: @check_in, status: :created, location: @check_in }
      else
        format.html { render action: "new" }
        format.json { render json: @check_in.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /check_ins/1
  # PUT /check_ins/1.json
  def update
    @check_in.user = current_user
    respond_to do |format|
      if @check_in.update_attributes(params[:check_in])
        format.html { redirect_to room_check_in_url(@room, @check_in), notice: t('record.updated', :record => t('model.check_in')) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @check_in.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /check_ins/1
  # DELETE /check_ins/1.json
  def destroy
    @check_in.destroy

    respond_to do |format|
      format.html { redirect_to room_check_ins_url(@room), notice: t('record.deleted', :record => t('model.check_in')) }
      format.json { head :no_content }
    end
  end
end
