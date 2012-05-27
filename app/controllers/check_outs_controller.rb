class CheckOutsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  before_filter :load_room
  before_filter :load_currencies
  before_filter :check_room_occupation, :except => :index
  # GET /check_outs
  # GET /check_outs.json
  def index
    @check_outs = @room.check_outs

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @check_outs }
    end
  end

  # GET /check_outs/1
  # GET /check_outs/1.json
  def show
    @check_out = CheckOut.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @check_out }
    end
  end

  # GET /check_outs/new
  # GET /check_outs/new.json
  def new
    @check_out = CheckOut.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @check_out }
    end
  end

  # GET /check_outs/1/edit
  def edit
    @check_out = CheckOut.find(params[:id])
  end

  # POST /check_outs
  # POST /check_outs.json
  def create
    @check_out = @room.check_outs.new(params[:check_out])
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
    @check_out = CheckOut.find(params[:id])
    @check_out.destroy

    respond_to do |format|
      format.html { redirect_to room_check_outs_url(@room), notice: t('record.deleted', :record => t('model.check_out')) }
      format.json { head :no_content }
    end
  end
  private
  def load_room
    @room = Room.find params[:room_id]
  end
  def check_room_occupation
    if @room.current_check_in.blank?
      redirect_to room_check_outs_url(@room), notice: 'Cannot create check out of none occupied room'
    end
  end
end
