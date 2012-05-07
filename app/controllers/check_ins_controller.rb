class CheckInsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  before_filter :load_room
  before_filter :load_currencies
  # GET /check_ins
  # GET /check_ins.json
  def index
    if CheckIn::STATUS.stringify_keys.keys.include?(params[:status])
      @check_ins = @room.check_ins.send(params[:status])
    else
      @check_ins = @room.check_ins
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @check_ins }
    end
  end

  # GET /check_ins/1
  # GET /check_ins/1.json
  def show
    @check_in = CheckIn.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @check_in }
    end
  end

  # GET /check_ins/new
  # GET /check_ins/new.json
  def new
    @check_in = CheckIn.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @check_in }
    end
  end

  # GET /check_ins/1/edit
  def edit
    @check_in = CheckIn.find(params[:id])
  end

  # POST /check_ins
  # POST /check_ins.json
  def create
    @check_in = @room.check_ins.new(params[:check_in])
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
    @check_in = CheckIn.find(params[:id])

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
    @check_in = CheckIn.find(params[:id])

    respond_to do |format|
      if @check_in.destroy
        format.html { redirect_to room_check_ins_url(@room), notice: t('record.deleted', :record => t('model.check_in')) }
        format.json { head :no_content }
      else
        format.html { redirect_to room_check_ins_url(@room), alert: @check_in.errors.full_messages }
        format.json { render json: @check_in.errors }
      end
    end
  end
  private
  def load_room
    @room = Room.find params[:room_id]
  end
end
