require 'spec_helper'

describe CheckOutsController do
  context "not signed in user" do
    it_should_only_allow_access_to_signed_in_user([:index, :show, :new, :create, :edit, :update, :destroy])
  end
  it_should_only_allow_access_to([:index, :show, :new, :create, :edit, :update, :destroy], :all) do |controller|
    controller.stub(:load_room)
  end

  context "signed in user" do
    before do
      @user = User.make!(:staff)
      @hotel = Hotel.make!(:owner => User.make(:hotel_owner))
      @hotel.update_attributes(:staff_members => [@user])
      @room_type = RoomType.make!(:hotel => @hotel)
      @room = Room.make!(:room_type => @room_type)
      @guest = Guest.make!
      @check_in = CheckIn.make!(:room => @room, :guest => @guest, :user => @user)
      sign_in @user
    end

  def valid_attributes
    {:user_id => @user.id, :guest_id => @guest.id, :room_id => @room.id,
     :additional_charges => "$0"}
  end

  describe "GET index" do
    it "assigns all check_outs as @check_outs" do
      check_out = CheckOut.create! valid_attributes
      get :index, {:room_id => @room.id}
      assigns(:check_outs).should eq([check_out])
    end
  end

  describe "GET show" do
    it "assigns the requested check_out as @check_out" do
      check_out = CheckOut.create! valid_attributes
      get :show, {:id => check_out.to_param, :room_id => @room.id}
      assigns(:check_out).should eq(check_out)
    end
  end

  describe "GET new" do
    it "assigns a new check_out as @check_out" do
      get :new, {:room_id => @room.id}
      assigns(:check_out).should be_a_new(CheckOut)
    end
  end

  describe "GET edit" do
    it "assigns the requested check_out as @check_out" do
      check_out = CheckOut.create! valid_attributes
      get :edit, {:id => check_out.to_param, :room_id => @room.id}
      assigns(:check_out).should eq(check_out)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new CheckOut" do
        expect {
          post :create, {:check_out => valid_attributes, :room_id => @room.id}
        }.to change(CheckOut, :count).by(1)
      end

      it "assigns a newly created check_out as @check_out" do
        post :create, {:check_out => valid_attributes, :room_id => @room.id}
        assigns(:check_out).should be_a(CheckOut)
        assigns(:check_out).should be_persisted
      end

      it "redirects to the created check_out" do
        post :create, {:check_out => valid_attributes, :room_id => @room.id}
        response.should redirect_to(room_check_out_url(@room, CheckOut.last))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved check_out as @check_out" do
        # Trigger the behavior that occurs when invalid params are submitted
        CheckOut.any_instance.stub(:save).and_return(false)
        post :create, {:check_out => {}, :room_id => @room.id}
        assigns(:check_out).should be_a_new(CheckOut)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        CheckOut.any_instance.stub(:save).and_return(false)
        post :create, {:check_out => {}, :room_id => @room.id}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested check_out" do
        check_out = CheckOut.create! valid_attributes
        # Assuming there are no other check_outs in the database, this
        # specifies that the CheckOut created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        CheckOut.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => check_out.to_param, :check_out => {'these' => 'params'}, :room_id => @room.id}
      end

      it "assigns the requested check_out as @check_out" do
        check_out = CheckOut.create! valid_attributes
        put :update, {:id => check_out.to_param, :check_out => valid_attributes, :room_id => @room.id}
        assigns(:check_out).should eq(check_out)
      end

      it "redirects to the check_out" do
        check_out = CheckOut.create! valid_attributes
        put :update, {:id => check_out.to_param, :check_out => valid_attributes, :room_id => @room.id}
        response.should redirect_to(room_check_out_url(@room, check_out))
      end
    end

    describe "with invalid params" do
      it "assigns the check_out as @check_out" do
        check_out = CheckOut.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        CheckOut.any_instance.stub(:save).and_return(false)
        put :update, {:id => check_out.to_param, :check_out => {}, :room_id => @room.id}
        assigns(:check_out).should eq(check_out)
      end

      it "re-renders the 'edit' template" do
        check_out = CheckOut.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        CheckOut.any_instance.stub(:save).and_return(false)
        put :update, {:id => check_out.to_param, :check_out => {}, :room_id => @room.id}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested check_out" do
      check_out = CheckOut.create! valid_attributes
      expect {
        delete :destroy, {:id => check_out.to_param, :room_id => @room.id}
      }.to change(CheckOut, :count).by(-1)
    end

    it "redirects to the check_outs list" do
      check_out = CheckOut.create! valid_attributes
      delete :destroy, {:id => check_out.to_param, :room_id => @room.id}
      response.should redirect_to(room_check_outs_url(@room))
    end
  end

  end
end
