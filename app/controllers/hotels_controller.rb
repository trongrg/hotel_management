class HotelsController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!
  before_filter :load_owner

  load_and_authorize_resource

  expose(:hotel)

  layout :determine_layout

  # GET /hotels
  # GET /hotels.json
  def index
    @hotels = Hotel.accessible_by(current_ability, :index).page(params[:page])
  end

  # GET /hotels/1
  # GET /hotels/1.json
  def show
  end

  # GET /hotels/new
  # GET /hotels/new.json
  def new
  end

  # GET /hotels/1/edit
  def edit
  end

  # POST /hotels
  # POST /hotels.json
  def create
    create_response @hotel.save, @hotel, "created", "new"
  end

  # PUT /hotels/1
  # PUT /hotels/1.json
  def update
    create_response @hotel.update_attributes(params[:hotel]), @hotel, "updated", "edit"
  end

  # DELETE /hotels/1
  # DELETE /hotels/1.json
  def destroy
    create_response @hotel.destroy, @hotel, "deleted", "show"
  end

  private
  def load_owner
    @owner = current_user
  end

  def determine_layout
    if request.xhr?
      false
    else
      'application'
    end
  end
end
