require 'spec_helper'

describe RoomsController do
  context "not signed in user" do
    it_should_only_allow_access_to_signed_in_user([:index, :show, :new, :create, :edit, :update, :destroy])
  end
  it_should_only_allow_access_to([:index, :show, :new, :create, :edit, :update, :destroy], [:admin, :hotel_owner]) do |controller|
    controller.stub(:load_hotel)
  end

  def valid_attributes
    {:number => "101", :room_type_id => room_type.to_param}
  end

  let(:hotel) { Hotel.make! }
  let(:room_type) { RoomType.make!(:hotel => hotel) }

  context "with authorized user (admin/hotel_owner)" do
    before do
      sign_in User.make!(:admin)
    end

    describe "GET index" do
      it "assigns all rooms as @rooms" do
        room = Room.create! valid_attributes
        get :index, {:hotel_id => hotel.to_param}
        assigns(:rooms).should eq([room])
      end
    end

    describe "GET show" do
      it "assigns the requested room as @room" do
        room = Room.create! valid_attributes
        get :show, {:id => room.to_param, :hotel_id => hotel.to_param}
        assigns(:room).should eq(room)
      end
    end

    describe "GET new" do
      it "assigns a new room as @room" do
        get :new, {:hotel_id => hotel.to_param}
        assigns(:room).should be_a_new(Room)
      end
    end

    describe "GET edit" do
      it "assigns the requested room as @room" do
        room = Room.create! valid_attributes
        get :edit, {:id => room.to_param, :hotel_id => hotel.to_param}
        assigns(:room).should eq(room)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Room" do
          expect {
            post :create, {:room => valid_attributes, :hotel_id => hotel.to_param}
          }.to change(Room, :count).by(1)
        end

        it "assigns a newly created room as @room" do
          post :create, {:room => valid_attributes, :hotel_id => hotel.to_param}
          assigns(:room).should be_a(Room)
          assigns(:room).should be_persisted
        end

        it "redirects to the created room" do
          post :create, {:room => valid_attributes, :hotel_id => hotel.to_param}
          response.should redirect_to hotel_room_path(hotel, Room.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved room as @room" do
          # Trigger the behavior that occurs when invalid params are submitted
          Room.any_instance.stub(:save).and_return(false)
          post :create, {:room => {}, :hotel_id => hotel.to_param}
          assigns(:room).should be_a_new(Room)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Room.any_instance.stub(:save).and_return(false)
          post :create, {:room => {}, :hotel_id => hotel.to_param}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested room" do
          room = Room.create! valid_attributes
          # Assuming there are no other rooms in the database, this
          # specifies that the Room created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Room.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, {:id => room.to_param, :room => {'these' => 'params'}, :hotel_id => hotel.to_param}
        end

        it "assigns the requested room as @room" do
          room = Room.create! valid_attributes
          put :update, {:id => room.to_param, :room => valid_attributes, :hotel_id => hotel.to_param}
          assigns(:room).should eq(room)
        end

        it "redirects to the room" do
          room = Room.create! valid_attributes
          put :update, {:id => room.to_param, :room => valid_attributes, :hotel_id => hotel.to_param}
          response.should redirect_to hotel_room_path(hotel, room)
        end
      end

      describe "with invalid params" do
        it "assigns the room as @room" do
          room = Room.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Room.any_instance.stub(:save).and_return(false)
          put :update, {:id => room.to_param, :room => {}, :hotel_id => hotel.to_param}
          assigns(:room).should eq(room)
        end

        it "re-renders the 'edit' template" do
          room = Room.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Room.any_instance.stub(:save).and_return(false)
          put :update, {:id => room.to_param, :room => {}, :hotel_id => hotel.to_param}
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested room" do
        room = Room.create! valid_attributes
        expect {
          delete :destroy, {:id => room.to_param, :hotel_id => hotel.to_param}
        }.to change(Room, :count).by(-1)
      end

      it "redirects to the rooms list" do
        room = Room.create! valid_attributes
        delete :destroy, {:id => room.to_param, :hotel_id => hotel.to_param}
        response.should redirect_to(hotel_rooms_url)
      end
    end
  end
end
