require 'spec_helper'

describe RoomsController do
  let(:user) { User.make!(:hotel_owner) }
  let(:hotel) { Hotel.make!(:owner => user) }
  let(:room_type) { RoomType.make!(:hotel => hotel)}
  let!(:room) { Room.make!(:room_type => room_type) }
  let(:valid_attributes) { { "name" => "MyString", :room_type_id => room_type.id } }
  let(:action) { }

  context "unauthenticated user" do
    before { action }
    describe "GET index" do
      let(:action) { get :index, {:hotel_id => hotel.to_param} }
      it_should_behave_like "unauthenticated"
    end

    describe "GET show" do
      let(:action) { get :show, {:hotel_id => hotel.to_param, :id => room} }
      it_should_behave_like "unauthenticated"
    end

    describe "GET edit" do
      let(:action) { get :edit, {:hotel_id => hotel.to_param, :id => room} }
      it_should_behave_like "unauthenticated"
    end

    describe "POST create" do
      let(:action) { post :create, {:hotel_id => hotel, :room => valid_attributes} }
      it_should_behave_like "unauthenticated"
    end

    describe "PUT update" do
      let(:action) { put :update, {:hotel_id => hotel.to_param, :room => valid_attributes, :id => room} }
      it_should_behave_like "unauthenticated"
    end

    describe "DELETE destroy" do
      let(:action) { delete :destroy, {:hotel_id => hotel.to_param, :id => room} }
      it_should_behave_like "unauthenticated"
    end
  end

  context "authenticated user" do
    before do
      sign_in user
      action
    end

    context "who owns the hotel" do
      let(:hotel) { Hotel.make!(:owner => user) }

      describe "GET index" do
        let(:action) { get :index, :hotel_id => hotel.to_param }
        before { Room.make! }

        it "returns http success" do
          get :index, :hotel_id => hotel.to_param
          response.should be_success
        end

        it "assigns all hotel's rooms as @rooms" do
          assigns(:rooms).should == [room]
        end
      end

      describe "GET show" do
        context "with permission" do
          let(:action) { get :show, {:id => room.to_param, :hotel_id => hotel.to_param} }
          it "assigns the requested room as @room" do
            assigns(:room).should == room
          end
        end

        context 'without permission' do
          let(:room) { Room.make! }
          it "cannot find the room" do
            expect {
              get :show, {:id => room.to_param, :hotel_id => hotel}
            }.to raise_error(ActiveRecord::RecordNotFound)
          end
        end
      end

      describe "GET new" do
        let(:action) { get :new, {:hotel_id => hotel.to_param} }
        it "assigns a new room as @room" do
          assigns(:room).should be_a_new(Room)
        end
      end

      describe "GET edit" do
        context "with permission" do
          let(:action) { get :edit, {:id => room.to_param, :hotel_id => hotel.to_param} }
          it "assigns the requested room as @room" do
            assigns(:room).should == room
          end
        end

        context 'without permission' do
          let(:room) { Room.make! }
          it "cannot find the room" do
            expect {
              get :edit, {:id => room.to_param, :hotel_id => hotel.to_param}
            }.to raise_error(ActiveRecord::RecordNotFound)
          end
        end
      end

      describe "POST create" do
        describe "with valid params" do
          it "creates a new Room" do
            expect { post :create, {:room => valid_attributes, :hotel_id => hotel.to_param}
            }.to change(Room, :count).by(1)
          end

          it "assigns a newly created room as @room" do
            post :create, {:room => valid_attributes, :hotel_id => hotel.to_param}
            assigns(:room).should be_a(Room)
            assigns(:room).should be_persisted
          end

          it "redirects to the created room" do
            post :create, {:room => valid_attributes, :hotel_id => hotel.to_param}
            response.should redirect_to([hotel, Room.last])
          end
        end

        describe "with invalid params" do
          let!(:errors) { RoomType.create.errors }
          before { RoomType.any_instance.stub(:errors).and_return errors }

          it "assigns a newly created but unsaved room as @room" do
            post :create, {:room_type => {:hotel_id => hotel.to_param}, :hotel_id => hotel}
            assigns(:room).should be_a_new(Room)
          end

          it "re-renders the 'new' template" do
            post :create, {:room_type => {:hotel_id => hotel.to_param}, :hotel_id => hotel}
            response.should render_template("new")
          end
        end
      end

      describe "PUT update" do
        context "with permission" do
          context "and valid params" do
            let(:action) { put :update, {:id => room.to_param, :hotel_id => hotel.to_param, :room => { "name" => "new name" }} }
            it "updates the requested room" do
              Room.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
              put :update, {:id => room.to_param, :room => { "name" => "MyString" }}
            end

            it "assigns the requested room as @room" do
              assigns(:room).should == room
            end

            it "redirects to the room" do
              response.should redirect_to([hotel, room])
            end
          end

          context "but invalid params" do
            let(:action) { put :update, {:id => room.to_param, :hotel_id => hotel.to_param, :room => { "name" => "" }} }

            it "assigns the room as @room" do
              assigns(:room).should == room
            end

            it "re-renders the 'edit' template" do
              response.should render_template("edit")
            end
          end
        end

        context "without permission" do
          let(:room) { Room.make! }
          it "cannot find the room" do
            expect {
              put :update, {:id => room.to_param, :hotel_id => hotel}
            }.to raise_error(ActiveRecord::RecordNotFound)
          end
        end
      end

      describe "DELETE destroy" do
        context "with permission" do
          it "destroys the requested room" do
            expect {
              delete :destroy, {:id => room.to_param, :hotel_id => hotel.to_param}
            }.to change(Room, :count).by(-1)
          end

          it "redirects to the rooms list" do
            delete :destroy, {:id => room.to_param, :hotel_id => hotel.to_param}
            response.should redirect_to(hotel_rooms_url(hotel))
          end
        end

        context 'without permission' do
          let(:room) { Room.make! }
          it "cannot find the room" do
            expect {
              delete :destroy, {:id => room.to_param, :hotel_id => hotel, :room_type => {} }
            }.to raise_error(ActiveRecord::RecordNotFound)
          end
        end
      end
    end

    context "who does not own the hotel" do
      let(:hotel) { Hotel.make! }

      describe "GET index" do
        let(:action) { get :index, {:hotel_id => hotel.to_param} }
        it_should_behave_like "unauthorized"
      end

      describe "GET show" do
        let(:room) { Room.make!(:room_type => room_type) }
        let(:action) { get :show, {:hotel_id => hotel.to_param, :id => room} }
        it_should_behave_like "unauthorized"
      end

      describe "GET edit" do
        let(:room) { Room.make!(:room_type => room_type) }
        let(:action) { get :edit, {:hotel_id => hotel.to_param, :id => room} }
        it_should_behave_like "unauthorized"
      end

      describe "POST create" do
        let(:action) { post :create, {:hotel_id => hotel.to_param, :room => valid_attributes} }
        it_should_behave_like "unauthorized"
      end

      describe "PUT update" do
        let(:room) { Room.make!(:room_type => room_type) }
        let(:action) { put :update, {:hotel_id => hotel.to_param, :room => valid_attributes, :id => room} }
        it_should_behave_like "unauthorized"
      end

      describe "DELETE destroy" do
        let(:room) { Room.make!(:room_type => room_type) }
        let(:action) { delete :destroy, {:hotel_id => hotel.to_param, :id => room} }
        it_should_behave_like "unauthorized"
      end
    end
  end
end
