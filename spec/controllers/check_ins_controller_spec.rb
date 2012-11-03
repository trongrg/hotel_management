require 'spec_helper'

describe CheckInsController do
  context "signed in user" do
    before do
      @user = User.make!(:staff)
      @hotel = Hotel.make!(:owner => User.make(:hotel_owner))
      @hotel.staff_members << @user
      @hotel.save
      @room = @hotel.room_types.make!.rooms.make!
      @guest = Guest.make!
      sign_in @user
    end

  def valid_attributes
    {:user_id => @user.id, :guest_id => @guest.id, :room_id => @room.id, :status => 'Active'}
  end

  describe "GET index" do
    it "assigns all check_ins as @check_ins" do
      check_in = CheckIn.create! valid_attributes
      check_in2 = CheckIn.make!
      get :index, {:room_id => @room.id}
      assigns(:check_ins).should eq([check_in])
    end
  end

  describe "GET show" do
    it "assigns the requested check_in as @check_in" do
      check_in = CheckIn.create! valid_attributes
      get :show, {:id => check_in.to_param, :room_id => @room.id}
      assigns(:check_in).should eq(check_in)
    end
  end

  describe "GET new" do
    it "assigns a new check_in as @check_in" do
      get :new, {:room_id => @room.id}
      assigns(:check_in).should be_a_new(CheckIn)
    end
  end

  describe "GET edit" do
    it "assigns the requested check_in as @check_in" do
      check_in = CheckIn.create! valid_attributes
      get :edit, {:id => check_in.to_param, :room_id => @room.id}
      assigns(:check_in).should eq(check_in)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new CheckIn" do
        expect {
          post :create, {:check_in => valid_attributes, :room_id => @room.id}
        }.to change(CheckIn, :count).by(1)
      end

      it "assigns a newly created check_in as @check_in" do
        post :create, {:check_in => valid_attributes, :room_id => @room.id}
        assigns(:check_in).should be_a(CheckIn)
        assigns(:check_in).should be_persisted
      end

      it "redirects to the check ins list" do
        post :create, {:check_in => valid_attributes, :room_id => @room.id}
        response.should redirect_to(room_check_ins_url(@room))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved check_in as @check_in" do
        # Trigger the behavior that occurs when invalid params are submitted
        CheckIn.any_instance.stub(:save).and_return(false)
        post :create, {:check_in => {}, :room_id => @room.id}
        assigns(:check_in).should be_a_new(CheckIn)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        CheckIn.any_instance.stub(:save).and_return(false)
        post :create, {:check_in => {}, :room_id => @room.id}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested check_in" do
        check_in = CheckIn.create! valid_attributes
        # Assuming there are no other check_ins in the database, this
        # specifies that the CheckIn created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        CheckIn.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => check_in.to_param, :check_in => {'these' => 'params'}, :room_id => @room.id}
      end

      it "assigns the requested check_in as @check_in" do
        check_in = CheckIn.create! valid_attributes
        put :update, {:id => check_in.to_param, :check_in => valid_attributes, :room_id => @room.id}
        assigns(:check_in).should eq(check_in)
      end

      it "redirects to the check ins list" do
        check_in = CheckIn.create! valid_attributes
        put :update, {:id => check_in.to_param, :check_in => valid_attributes, :room_id => @room.id}
        response.should redirect_to(room_check_ins_url(@room))
      end
    end

    describe "with invalid params" do
      it "assigns the check_in as @check_in" do
        check_in = CheckIn.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        CheckIn.any_instance.stub(:save).and_return(false)
        put :update, {:id => check_in.to_param, :check_in => {}, :room_id => @room.id}
        assigns(:check_in).should eq(check_in)
      end

      it "re-renders the 'edit' template" do
        check_in = CheckIn.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        CheckIn.any_instance.stub(:save).and_return(false)
        put :update, {:id => check_in.to_param, :check_in => {}, :room_id => @room.id}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested check_in" do
      check_in = CheckIn.create! valid_attributes
      expect {
        delete :destroy, {:id => check_in.to_param, :room_id => @room.id}
      }.to change(CheckIn, :count).by(-1)
    end

    it "redirects to the check ins list" do
      check_in = CheckIn.create! valid_attributes
      delete :destroy, {:id => check_in.to_param, :room_id => @room.id}
      response.should redirect_to(room_check_ins_url(@room))
    end
  end

  end
end
