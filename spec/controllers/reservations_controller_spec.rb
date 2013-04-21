require 'spec_helper'

describe ReservationsController do
  let(:user) { User.make!(:hotel_owner) }
  let(:hotel) { Hotel.make!(:owner => user) }
  let(:room_type) { RoomType.make!(:hotel => hotel) }
  let(:room) { Room.make!(:room_type => room_type) }
  let!(:reservation) { Reservation.make!(:rooms => [room], :hotel => hotel) }
  let(:action) { }
  let(:valid_attributes) do
    {
      :guest_attributes =>
      {
        :first_name => 'Trong',
        :last_name => 'Tran',
        :passport => '250737373',
        :phone => '0987654321',
        :gender => "Male"
      },
      :check_in_date => DateTime.now.to_date,
      :check_out_date => 1.day.from_now.to_date,
      :room_ids => [room.id]
    }
  end

  context "unauthenticated user" do
    before { action }
    describe "GET index" do
      let(:action) { get :index, {:hotel_id => hotel.to_param} }
      it_should_behave_like "unauthenticated"
    end

    describe "GET show" do
      let(:action) { get :show, {:hotel_id => hotel.to_param, :id => reservation} }
      it_should_behave_like "unauthenticated"
    end

    describe "GET edit" do
      let(:action) { get :edit, {:hotel_id => hotel.to_param, :id => reservation} }
      it_should_behave_like "unauthenticated"
    end

    describe "POST create" do
      let(:action) { post :create, {:hotel_id => hotel, :reservation => valid_attributes} }
      it_should_behave_like "unauthenticated"
    end

    describe "PUT update" do
      let(:action) { put :update, {:hotel_id => hotel.to_param, :reservation => valid_attributes, :id => room} }
      it_should_behave_like "unauthenticated"
    end

    describe "DELETE destroy" do
      let(:action) { delete :destroy, {:hotel_id => hotel.to_param, :id => reservation} }
      it_should_behave_like "unauthenticated"
    end
  end

  context "authenticated user" do
    before do
      sign_in user
      action
    end

    context "who owns the hotel" do
      describe "GET index" do
        let(:action) { get :index, :hotel_id => hotel.to_param }
        it "assigns all reservations as @reservations" do
          assigns(:reservations).should eq([reservation])
        end
      end

      describe "GET show" do
        context "with permission" do
          let(:action) { get :show, :id => reservation.to_param, :hotel_id => hotel.to_param }
          it "assigns the requested reservation as @reservation" do
            assigns(:reservation).should eq(reservation)
          end
        end

        context "without permission" do
          let(:reservation) { Reservation.make! }
          it "cannot find the reservation" do
            expect {
              get :show, {:id => reservation.to_param, :hotel_id => hotel}
            }.to raise_error(ActiveRecord::RecordNotFound)
          end
        end
      end

      describe "GET new" do
        let(:action) { get :new, :hotel_id => hotel.to_param }
        it "assigns a new reservation as @reservation" do
          assigns(:reservation).should be_a_new(Reservation)
        end
      end

      describe "GET edit" do
        context "with permission" do
          let(:action) { get :edit, :id => reservation.to_param, :hotel_id => hotel.to_param }
          it "assigns the requested reservation as @reservation" do
            assigns(:reservation).should eq(reservation)
          end
        end

        context 'without permission' do
          let(:reservation) { Reservation.make! }
          it "cannot find the reservation" do
            expect {
              get :edit, {:id => reservation.to_param, :hotel_id => hotel.to_param}
            }.to raise_error(ActiveRecord::RecordNotFound)
          end
        end
      end

      describe "POST create" do
        describe "and valid params" do
          it "creates a new Reservation" do
            expect {
              post :create, {:reservation => valid_attributes, :hotel_id => hotel.to_param}
            }.to change(Reservation, :count).by(1)
          end

          it "assigns a newly created reservation as @reservation" do
            post :create, {:reservation => valid_attributes, :hotel_id => hotel.to_param}
            assigns(:reservation).should be_a(Reservation)
            assigns(:reservation).should be_persisted
          end

          it "redirects to the created reservation" do
            post :create, {:reservation => valid_attributes, :hotel_id => hotel.to_param}
            response.should redirect_to([hotel, Reservation.last])
          end
        end

        describe "and invalid params" do
          let!(:errors) { Reservation.create.errors }
          let(:action) { post :create, {:reservation => { "check_in_date" => "invalid value" }, :hotel_id => hotel.to_param} }
          before { Reservation.any_instance.stub(:errors).and_return errors }

          it "assigns a newly created but unsaved reservation as @reservation" do
            assigns(:reservation).should be_a_new(Reservation)
          end

          it "re-renders the 'new' template" do
            response.should render_template("new")
          end
        end
      end

      describe "PUT update" do
        context "with permission" do
          describe "with valid params" do
            let(:action) { }
            it "updates the requested reservation" do
              Reservation.any_instance.should_receive(:update_attributes).with({ "check_in_date" => "" })
              put :update, {:id => reservation.to_param, :hotel_id => hotel.to_param, :reservation => { "check_in_date" => "" }}
            end

            it "assigns the requested reservation as @reservation" do
              put :update, {:id => reservation.to_param, :hotel_id => hotel.to_param, :reservation => { "check_in_date" => 1.day.from_now }}
              assigns(:reservation).should eq(reservation)
            end

            it "redirects to the reservation" do
              put :update, {:id => reservation.to_param, :hotel_id => hotel.to_param, :reservation => { "check_in_date" => 1.day.from_now }}
              response.should redirect_to([hotel, reservation])
            end
          end

          describe "with invalid params" do
            let!(:errors) { Reservation.create.errors }
            let(:action) { put :update, {:id => reservation.to_param, :hotel_id => hotel.to_param, :reservation => { "check_in_date" => "invalid value" }} }
            before { Reservation.any_instance.stub(:errors).and_return errors }

            it "assigns the reservation as @reservation" do
              assigns(:reservation).should eq(reservation)
            end

            it "re-renders the 'edit' template" do
              response.should render_template("edit")
            end
          end
        end

        context "without permission" do
          let(:reservation) { Reservation.make! }
          it "cannot find the reservation" do
            expect {
              put :update, {:id => reservation.to_param, :hotel_id => hotel}
            }.to raise_error(ActiveRecord::RecordNotFound)
          end
        end
      end

      describe "DELETE destroy" do
        context "with permission" do
          it "destroys the requested reservation" do
            expect {
              delete :destroy, {:id => reservation.to_param, :hotel_id => hotel.to_param}
            }.to change(Reservation, :count).by(-1)
          end

          it "redirects to the reservations list" do
            delete :destroy, {:id => reservation.to_param, :hotel_id => hotel.to_param}
            response.should redirect_to(hotel_reservations_url(hotel))
          end
        end
      end

      context 'without permission' do
        let(:reservation) { Reservation.make! }
        it "cannot find the reservation" do
          expect {
            delete :destroy, {:id => reservation.to_param, :hotel_id => hotel }
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context "who does not own the hotel" do
      let(:hotel) { Hotel.make! }
      let(:reservation) { Reservation.make!(:hotel => hotel) }

      describe "GET index" do
        let(:action) { get :index, {:hotel_id => hotel.to_param} }
        it_should_behave_like "unauthorized"
      end

      describe "GET show" do
        let(:action) { get :show, {:hotel_id => hotel.to_param, :id => reservation} }
        it_should_behave_like "unauthorized"
      end

      describe "GET edit" do
        let(:action) { get :edit, {:hotel_id => hotel.to_param, :id => reservation} }
        it_should_behave_like "unauthorized"
      end

      describe "POST create" do
        let(:action) { post :create, {:hotel_id => hotel.to_param, :reservation => valid_attributes} }
        it_should_behave_like "unauthorized"
      end

      describe "PUT update" do
        let(:action) { put :update, {:hotel_id => hotel.to_param, :room => valid_attributes, :id => reservation} }
        it_should_behave_like "unauthorized"
      end

      describe "DELETE destroy" do
        let(:action) { delete :destroy, {:hotel_id => hotel.to_param, :id => reservation} }
        it_should_behave_like "unauthorized"
      end
    end
  end
end
