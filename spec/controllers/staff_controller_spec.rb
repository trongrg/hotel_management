require 'spec_helper'

describe StaffController do
  context "with signed in hotel owner" do
    before do
      @user = User.make!(:hotel_owner)
      sign_in @user
      @hotel = @user.hotels.make!
      @hotel.staff_members = (1..2).map { User.make!(:staff) }
      @hotel.save
      @staff_members = @hotel.staff_members
      @other_staff = User.make!(:staff)
    end

    describe "GET 'index'" do
      it "returns http success" do
        get :index, :hotel_id => @hotel
        response.should be_success
      end

      it "assigns all staff of the hotel to @staff" do
        get :index, :hotel_id => @hotel
        assigns(:staff).to_a.should == @staff_members
      end
    end

    describe "GET 'show'" do
      before do
        get :show, :hotel_id => @hotel, :id => @staff_members.first
      end
      it "returns http success" do
        response.should be_success
      end
      it "assigns the staff member as @staff_member" do
        assigns(:staff_member).should == @staff_members.first
      end
    end

    describe "GET 'destroy'" do
      before do
        get :destroy, :hotel_id => @hotel, :id => @staff_members.first
      end
      it "redirects to hotel staff index path" do
        response.should redirect_to hotel_staff_index_path(@hotel)
      end
      it "destroys the relation between the hotel and staff member" do
        @hotel.reload.staff_members.should_not include(@staff_members.first)
      end
      it "shows notice message" do
        flash[:notice].should == I18n.t('record.removed', :record => I18n.t('model.user'))
      end
    end
  end
end
