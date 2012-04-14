class StaffController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_hotel
  before_filter :authorize
  def index
    @staff = @hotel.staff_members
    respond_to do |format|
      format.html
      format.json { render :json => @staff }
    end
  end

  def show
    @staff_member = @hotel.staff_members.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @staff_member }
    end
  end

  def destroy
    @staff_member = @hotel.staff_members.find(params[:id])
    @hotel.staff_members.delete(@staff_member)
    @hotel.save
    respond_to do |format|
      format.html { redirect_to hotel_staff_index_path(@hotel), :notice => t('record.removed', :record => t('model.staff_member')) }
      format.json { render :json => @hotel }
    end
  end
  protected
  def load_hotel
    @hotel = Hotel.find(params[:hotel_id])
    authorize! :read, @hotel
  end
  def authorize
    authorize! :manage, :staff
  end
end
