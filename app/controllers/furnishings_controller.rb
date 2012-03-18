class FurnishingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_room_type
  load_and_authorize_resource
  # GET /furnishings
  # GET /furnishings.json
  def index
    @furnishings = @room_type.furnishings.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @furnishings }
    end
  end

  # GET /furnishings/1
  # GET /furnishings/1.json
  def show
    @furnishing = Furnishing.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @furnishing }
    end
  end

  # GET /furnishings/new
  # GET /furnishings/new.json
  def new
    @furnishing = Furnishing.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @furnishing }
    end
  end

  # GET /furnishings/1/edit
  def edit
    @furnishing = Furnishing.find(params[:id])
  end

  # POST /furnishings
  # POST /furnishings.json
  def create
    @furnishing = @room_type.furnishings.new(params[:furnishing])

    respond_to do |format|
      if @furnishing.save
        format.html { redirect_to room_type_furnishing_path(@room_type, @furnishing), notice: t('record.created', :record => t('model.furnishing')) }
        format.json { render json: @furnishing, status: :created, location: @furnishing }
      else
        format.html { render action: "new" }
        format.json { render json: @furnishing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /furnishings/1
  # PUT /furnishings/1.json
  def update
    @furnishing = Furnishing.find(params[:id])

    respond_to do |format|
      if @furnishing.update_attributes(params[:furnishing])
        format.html { redirect_to room_type_furnishing_path(@room_type, @furnishing), notice: t('record.updated', :record => t('model.furnishing')) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @furnishing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /furnishings/1
  # DELETE /furnishings/1.json
  def destroy
    @furnishing = Furnishing.find(params[:id])
    @furnishing.destroy

    respond_to do |format|
      format.html { redirect_to room_type_furnishings_url(@room_type), notice: t('record.deleted', :record => t('model.furnishing')) }
      format.json { head :no_content }
    end
  end
  private
  def load_room_type
    @room_type = RoomType.find(params[:room_type_id])
  end
end
