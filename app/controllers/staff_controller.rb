class StaffController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!
  before_filter :load_hotel
  before_filter :authorize

  def index
    @staff = @hotel.staff_members.page(params[:page])
  end

  def show
    @staff_member = @hotel.staff_members.find(params[:id])
  end

  def destroy
    @staff_member = @hotel.staff_members.find(params[:id])
    @hotel.staff_members.delete(@staff_member)
    create_response @hotel.save, @staff_member, "removed", "show"
  end

  protected
  def authorize
    authorize! :manage, :staff
  end
end
