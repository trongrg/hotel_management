class HotelsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_owner
  load_and_authorize_resource
  # GET /hotels
  # GET /hotels.json
  def index
    @hotels = Hotel.accessible_by(current_ability, :index).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hotels }
    end
  end

  # GET /hotels/1
  # GET /hotels/1.json
  def show
    @hotel = Hotel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hotel }
    end
  end

  # GET /hotels/new
  # GET /hotels/new.json
  def new
    @hotel = Hotel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hotel }
    end
  end

  # GET /hotels/1/edit
  def edit
    @hotel = Hotel.find(params[:id])
  end

  # POST /hotels
  # POST /hotels.json
  def create
    @hotel = @owner.hotels.new(params[:hotel])

    respond_to do |format|
      if @hotel.save
        format.html { redirect_to hotel_path(@hotel), notice: t('record.created', :record => t('model.hotel')) }
        format.json { render json: @hotel, status: :created, location: @hotel }
      else
        format.html { render action: "new" }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hotels/1
  # PUT /hotels/1.json
  def update
    @hotel = Hotel.find(params[:id])

    respond_to do |format|
      if @hotel.update_attributes(params[:hotel])
        format.html { redirect_to hotel_path(@hotel), notice: t('record.updated', :record => t('model.hotel')) }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hotels/1
  # DELETE /hotels/1.json
  def destroy
    @hotel = Hotel.find(params[:id])
    @hotel.destroy

    respond_to do |format|
      format.html { redirect_to hotels_url, notice: t('record.deleted', :record => t('model.hotel')) }
      format.json { head :ok }
    end
  end

  protected
  def load_owner
    @owner = current_user
  end
end
