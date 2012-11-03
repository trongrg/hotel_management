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
      @room.check_outs
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

    respond_to do |format|
      if @check_out.save
        format.html { redirect_to room_check_out_url(@room, @check_out), notice: t('record.created', :record => t('model.check_out')) }
        format.json { render json: @check_out, status: :created, location: @check_out }
      else
        format.html { render action: "new" }
        format.json { render json: @check_out.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /check_outs/1
  # PUT /check_outs/1.json
  def update
    @check_out = CheckOut.find(params[:id])
    @check_out.user = current_user

    respond_to do |format|
      if @check_out.update_attributes(params[:check_out])
        format.html { redirect_to room_check_out_url(@room, @check_out), notice: t('record.updated', :record => t('model.check_out')) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @check_out.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /check_outs/1
  # DELETE /check_outs/1.json
  def destroy
    @check_out.destroy

    respond_to do |format|
      format.html { redirect_to room_check_outs_url(@room), notice: t('record.deleted', :record => t('model.check_out')) }
      format.json { head :no_content }
    end
  end

  private
  def check_room_occupation
    if @room.current_check_in.blank?
      redirect_to room_check_outs_url(@room), notice: 'Cannot create check out of none occupied room'
    end
  end
end
