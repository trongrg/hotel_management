require 'spec_helper'

describe ReservationsController do
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
      {:user_id => @user.id, :guest_id => @guest.id, :room_id => @room.id, :status => 'Active', :check_in_date => DateTime.now.to_date, :check_out_date => 1.day.from_now.to_date}
    end

    describe "GET index" do
      context "status is active" do
        it "assigns all active reservations as @reservations" do
          reservation1 = @room.reservations.create! valid_attributes
          reservation2 = @room.reservations.create! valid_attributes.merge(:status => "Expired")
          get :index, {:room_id => @room.id, :status => "active"}
          assigns(:reservations).should == [reservation1]
        end
      end
      context "status is expired" do
        it "assigns all expired reservations as @reservations" do
          reservation1 = @room.reservations.create! valid_attributes
          reservation2 = @room.reservations.create! valid_attributes.merge(:status => "Expired")
          get :index, {:room_id => @room.id, :status => "expired"}
          assigns(:reservations).should == [reservation2]
        end
      end
      context "status not given" do
        it "assigns all reservations of given room as @reservations" do
          reservation1 = @room.reservations.create! valid_attributes
          reservation2 = Reservation.create! valid_attributes.merge(:room => Room.make)
          get :index, {:room_id => @room.id}
          assigns(:reservations).should == [reservation1]
        end
      end
    end

    describe "GET show" do
      it "assigns the requested reservation as @reservation" do
        reservation = Reservation.create! valid_attributes
        get :show, {:id => reservation.to_param, :room_id => @room.id}
        assigns(:reservation).should eq(reservation)
      end
    end

    describe "GET new" do
      it "assigns a new reservation as @reservation" do
        get :new, {:room_id => @room.id}
        assigns(:reservation).should be_a_new(Reservation)
      end
    end

    describe "GET edit" do
      it "assigns the requested reservation as @reservation" do
        reservation = Reservation.create! valid_attributes
        get :edit, {:id => reservation.to_param, :room_id => @room.id}
        assigns(:reservation).should eq(reservation)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Reservation" do
          expect {
            post :create, {:reservation => valid_attributes, :room_id => @room.id}
          }.to change(Reservation, :count).by(1)
        end

        it "assigns a newly created reservation as @reservation" do
          post :create, {:reservation => valid_attributes, :room_id => @room.id}
          assigns(:reservation).should be_a(Reservation)
          assigns(:reservation).should be_persisted
        end

        it "redirects to reservations list" do
          post :create, {:reservation => valid_attributes, :room_id => @room.id}
          response.should redirect_to(room_reservations_url(@room))
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved reservation as @reservation" do
          # Trigger the behavior that occurs when invalid params are submitted
          Reservation.any_instance.stub(:save).and_return(false)
          post :create, {:reservation => {}, :room_id => @room.id}
          assigns(:reservation).should be_a_new(Reservation)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Reservation.any_instance.stub(:save).and_return(false)
          post :create, {:reservation => {}, :room_id => @room.id}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested reservation" do
          reservation = Reservation.create! valid_attributes
          # Assuming there are no other reservations in the database, this
          # specifies that the Reservation created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Reservation.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, {:id => reservation.to_param, :reservation => {'these' => 'params'}, :room_id => @room.id}
        end

        it "assigns the requested reservation as @reservation" do
          reservation = Reservation.create! valid_attributes
          put :update, {:id => reservation.to_param, :reservation => valid_attributes, :room_id => @room.id}
          assigns(:reservation).should eq(reservation)
        end

        it "redirects to reservations list" do
          reservation = Reservation.create! valid_attributes
          put :update, {:id => reservation.to_param, :reservation => valid_attributes, :room_id => @room.id}
          response.should redirect_to(room_reservations_url(@room))
        end
      end

      describe "with invalid params" do
        it "assigns the reservation as @reservation" do
          reservation = Reservation.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Reservation.any_instance.stub(:save).and_return(false)
          put :update, {:id => reservation.to_param, :reservation => {}, :room_id => @room.id}
          assigns(:reservation).should eq(reservation)
        end

        it "re-renders the 'edit' template" do
          reservation = Reservation.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Reservation.any_instance.stub(:save).and_return(false)
          put :update, {:id => reservation.to_param, :reservation => {}, :room_id => @room.id}
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested reservation" do
        reservation = Reservation.create! valid_attributes
        expect {
          delete :destroy, {:id => reservation.to_param, :room_id => @room.id}
        }.to change(Reservation, :count).by(-1)
      end

      it "redirects to reservations list" do
        reservation = Reservation.create! valid_attributes
        delete :destroy, {:id => reservation.to_param, :room_id => @room.id}
        response.should redirect_to(room_reservations_url(@room))
      end
    end
  end
end
