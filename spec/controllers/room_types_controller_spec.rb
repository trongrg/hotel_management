require 'spec_helper'

describe RoomTypesController do
  context "with signed in user" do
    context "which has permission" do
      before do
        @owner = User.make!(:hotel_owner)
        @hotel = Hotel.make!(:owner => @owner)
        sign_in @owner
      end

      def valid_attributes
        {:name => "Deluxe", :price_in_cents => 19900, :currency => "USD", :hotel_id => @hotel.id}
      end

      describe "GET index" do
        it "assigns all room_types as @room_types" do
          room_type = RoomType.create! valid_attributes
          get :index, { :hotel_id => @hotel}
          assigns(:room_types).should eq([room_type])
        end
      end

      describe "GET show" do
        it "assigns the requested room_type as @room_type" do
          room_type = RoomType.create! valid_attributes
          get :show, {:id => room_type.to_param, :hotel_id => @hotel}
          assigns(:room_type).should eq(room_type)
        end
      end

      describe "GET new" do
        it "assigns a new room_type as @room_type" do
          get :new, { :hotel_id => @hotel }
          assigns(:room_type).should be_a_new(RoomType)
        end
      end

      describe "GET edit" do
        it "assigns the requested room_type as @room_type" do
          room_type = RoomType.create! valid_attributes
          get :edit, {:id => room_type.to_param, :hotel_id => @hotel}
          assigns(:room_type).should eq(room_type)
        end
      end

      describe "POST create" do
        describe "with valid params" do
          it "creates a new RoomType" do
            expect {
              post :create, {:room_type => valid_attributes, :hotel_id => @hotel}
            }.to change(RoomType, :count).by(1)
          end

          it "assigns a newly created room_type as @room_type" do
            post :create, {:room_type => valid_attributes, :hotel_id => @hotel}
            assigns(:room_type).should be_a(RoomType)
            assigns(:room_type).should be_persisted
          end

          it "redirects to the created room_type" do
            post :create, {:room_type => valid_attributes, :hotel_id => @hotel}
            response.should redirect_to(hotel_room_type_path(@hotel, RoomType.last))
          end
        end

        describe "with invalid params" do
          it "assigns a newly created but unsaved room_type as @room_type" do
            # Trigger the behavior that occurs when invalid params are submitted
            RoomType.any_instance.stub(:save).and_return(false)
            post :create, {:room_type => {:hotel_id => @hotel.to_param}, :hotel_id => @hotel}
            assigns(:room_type).should be_a_new(RoomType)
          end

          it "re-renders the 'new' template" do
            # Trigger the behavior that occurs when invalid params are submitted
            RoomType.any_instance.stub(:save).and_return(false)
            post :create, {:room_type => {:hotel_id => @hotel.to_param}, :hotel_id => @hotel}
            response.should render_template("new")
          end
        end
      end

      describe "PUT update" do
        describe "with valid params" do
          it "updates the requested room_type" do
            room_type = RoomType.create! valid_attributes
            # Assuming there are no other room_types in the database, this
            # specifies that the RoomType created on the previous line
            # receives the :update_attributes message with whatever params are
            # submitted in the request.
            RoomType.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
            put :update, {:id => room_type.to_param, :room_type => {'these' => 'params'}, :hotel_id => @hotel}
          end

          it "assigns the requested room_type as @room_type" do
            room_type = RoomType.create! valid_attributes
            put :update, {:id => room_type.to_param, :room_type => valid_attributes, :hotel_id => @hotel}
            assigns(:room_type).should eq(room_type)
          end

          it "redirects to the room_type" do
            room_type = RoomType.create! valid_attributes
            put :update, {:id => room_type.to_param, :room_type => valid_attributes, :hotel_id => @hotel}
            response.should redirect_to(hotel_room_type_path(@hotel, room_type))
          end
        end

        describe "with invalid params" do
          it "assigns the room_type as @room_type" do
            room_type = RoomType.create! valid_attributes
            # Trigger the behavior that occurs when invalid params are submitted
            RoomType.any_instance.stub(:save).and_return(false)
            put :update, {:id => room_type.to_param, :room_type => {}, :hotel_id => @hotel}
            assigns(:room_type).should eq(room_type)
          end

          it "re-renders the 'edit' template" do
            room_type = RoomType.create! valid_attributes
            # Trigger the behavior that occurs when invalid params are submitted
            RoomType.any_instance.stub(:save).and_return(false)
            put :update, {:id => room_type.to_param, :room_type => {}, :hotel_id => @hotel}
            response.should render_template("edit")
          end
        end
      end

      describe "DELETE destroy" do
        it "destroys the requested room_type" do
          room_type = RoomType.create! valid_attributes
          expect {
            delete :destroy, {:id => room_type.to_param, :hotel_id => @hotel}
          }.to change(RoomType, :count).by(-1)
        end

        it "redirects to the room_types list" do
          room_type = RoomType.create! valid_attributes
          delete :destroy, {:id => room_type.to_param, :hotel_id => @hotel}
          response.should redirect_to(hotel_room_types_url)
        end
      end
    end

    context "which does not have permission" do
      before do
        @owner = User.make!(:hotel_owner)
        @hotel = Hotel.make!
        @room_type = RoomType.make!(:hotel => @hotel)
        sign_in @owner
      end

      describe "GET show" do
        before { get :show, :id => @room_type.id, :hotel_id => @hotel.id }
        it_should_behave_like "not authorized"
      end

      describe "Get edit" do
        before { get :edit, :hotel_id => @hotel.id, :id => @room_type.id }
        it_should_behave_like "not authorized"
      end

      describe "PUT update" do
        before { put :update, :hotel_id => @hotel.id, :id => @room_type.id, :room_type => {} }
        it_should_behave_like "not authorized"
      end

      describe "DELETE destroy" do
        before { delete :destroy, :hotel_id => @hotel.id, :id => @room_type.id }
        it_should_behave_like "not authorized"
      end
    end
  end
  context "with not signed in user" do
    describe "GET index" do
      before { get :index, :hotel_id => 1 }
      it_should_behave_like "not signed in"
    end
    describe "GET show" do
      before { get :show, :id => 1, :hotel_id => 1 }
      it_should_behave_like "not signed in"
    end
    describe "GET new" do
      before { get :new, :hotel_id => 1 }
      it_should_behave_like "not signed in"
    end
    describe "POST create" do
      before { post :create, :hotel_id => 1, :room_type => {} }
      it_should_behave_like "not signed in"
    end
    describe "Get edit" do
      before { get :edit, :hotel_id => 1, :id => 1 }
      it_should_behave_like "not signed in"
    end
    describe "PUT update" do
      before { put :update, :hotel_id => 1, :id => 1, :room_type => {} }
      it_should_behave_like "not signed in"
    end
    describe "DELETE destroy" do
      before { delete :destroy, :hotel_id => 1, :id => 1 }
      it_should_behave_like "not signed in"
    end
  end
end
