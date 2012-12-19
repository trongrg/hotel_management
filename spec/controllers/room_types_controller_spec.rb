require 'spec_helper'

describe RoomTypesController do
  context "with signed in user" do
    context "who owns the hotel" do
      before do
        @owner = User.make!(:hotel_owner)
        @hotel = Hotel.make!(:owners => [@owner])
        sign_in @owner
      end

      def valid_attributes
        {:name => "Deluxe", :price_cents => 19900, :currency => "USD", :hotel_id => @hotel.id}
      end

      describe "GET index" do
        it "assigns all room_types as @room_types" do
          room_type = RoomType.create! valid_attributes
          other_room_type = RoomType.make!
          get :index, { :hotel_id => @hotel }
          assigns(:room_types).should == [room_type]
        end
      end

      describe "GET show" do
        context "with permission" do
          let(:room_type) { RoomType.create! valid_attributes }
          before { get :show, {:id => room_type.to_param, :hotel_id => @hotel} }
          it "assigns the requested room_type as @room_type" do
            assigns(:room_type).should == room_type
          end
        end
        context 'without permission' do
          let(:room_type) { RoomType.make! }
          it "cannot find the room type" do
            expect {
              get :show, {:id => room_type.to_param, :hotel_id => @hotel}
            }.to raise_error(ActiveRecord::RecordNotFound)
          end
        end
      end

      describe "GET new" do
        it "assigns a new room_type as @room_type" do
          get :new, { :hotel_id => @hotel }
          assigns(:room_type).should be_a_new(RoomType)
        end
      end

      describe "GET edit" do
        context "with permission" do
          let(:room_type) { RoomType.create! valid_attributes }
          before { get :show, {:id => room_type.to_param, :hotel_id => @hotel} }
          it "assigns the requested room_type as @room_type" do
            assigns(:room_type).should == room_type
          end
        end
        context 'without permission' do
          let(:room_type) { RoomType.make! }
          it "cannot find the room type" do
            expect {
              get :edit, {:id => room_type.to_param, :hotel_id => @hotel}
            }.to raise_error(ActiveRecord::RecordNotFound)
          end
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

          it "redirects to newly created room type" do
            post :create, {:room_type => valid_attributes, :hotel_id => @hotel}
            response.should redirect_to(hotel_room_type_path(@hotel, assigns(:room_type)))
          end
        end

        describe "with invalid params" do
          let!(:room_type) { RoomType.create! valid_attributes }
          let!(:errors) { RoomType.create.errors }
          before { RoomType.any_instance.stub(:errors).and_return errors }

          it "assigns a newly created but unsaved room_type as @room_type" do
            post :create, {:room_type => {:hotel_id => @hotel.to_param}, :hotel_id => @hotel}
            assigns(:room_type).should be_a_new(RoomType)
          end

          it "re-renders the 'new' template" do
            post :create, {:room_type => {:hotel_id => @hotel.to_param}, :hotel_id => @hotel}
            response.should render_template("new")
          end
        end
      end

      describe "PUT update" do
        context "with permission" do
          describe "with valid params" do
            let!(:room_type) { RoomType.create!(valid_attributes) }

            it "updates the requested room_type" do
              RoomType.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
              put :update, {:id => room_type.to_param, :room_type => {'these' => 'params'}, :hotel_id => @hotel}
            end

            it "assigns the requested room_type as @room_type" do
              put :update, {:id => room_type.to_param, :room_type => valid_attributes, :hotel_id => @hotel}
              assigns(:room_type).should == room_type
            end

            it "redirects to updated room type" do
              put :update, {:id => room_type.to_param, :room_type => valid_attributes, :hotel_id => @hotel}
              response.should redirect_to(hotel_room_type_path(@hotel, room_type))
            end
          end

          describe "with invalid params" do
            let!(:room_type) { RoomType.create! valid_attributes }
            let!(:errors) { RoomType.create.errors }
            before { RoomType.any_instance.stub(:errors).and_return errors }

            it "assigns the room_type as @room_type" do
              put :update, {:id => room_type.to_param, :room_type => {}, :hotel_id => @hotel}
              assigns(:room_type).should == room_type
            end

            it "re-renders the 'edit' template" do
              put :update, {:id => room_type.to_param, :room_type => {}, :hotel_id => @hotel}
              response.should render_template("edit")
            end
          end
        end
        context 'without permission' do
          let(:room_type) { RoomType.make! }
          it "cannot find the room type" do
            expect {
              get :update, {:id => room_type.to_param, :hotel_id => @hotel, :room_type => {} }
            }.to raise_error(ActiveRecord::RecordNotFound)
          end
        end
      end

      describe "DELETE destroy" do
        context "with permission" do
          let!(:room_type) { RoomType.create!(valid_attributes) }

          it "destroys the requested room_type" do
            expect {
              delete :destroy, {:id => room_type.to_param, :hotel_id => @hotel}
            }.to change(RoomType, :count).by(-1)
          end

          it "redirects to room types list" do
            delete :destroy, {:id => room_type.to_param, :hotel_id => @hotel}
            response.should redirect_to(hotel_room_types_url)
          end
        end
      end
      context 'without permission' do
        let(:room_type) { RoomType.make! }
        it "cannot find the room type" do
          expect {
            get :update, {:id => room_type.to_param, :hotel_id => @hotel, :room_type => {} }
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context "who does not own the hotel" do
      before do
        @user = User.make!
        @hotel = Hotel.make!
        sign_in @user
      end

      def valid_attributes
        {:name => "Deluxe", :price_cents => 19900, :currency => "USD", :hotel_id => @hotel.id}
      end

      describe "GET index" do
        before { get :index, {:hotel_id => @hotel} }
        it_should_behave_like "not authorized"
      end

      describe "GET show" do
        let(:room_type) { RoomType.make!(:hotel => @hotel) }
        before { get :show, {:hotel_id => @hotel, :id => room_type} }
        it_should_behave_like "not authorized"
      end

      describe "GET edit" do
        let(:room_type) { RoomType.make!(:hotel => @hotel) }
        before { get :edit, {:hotel_id => @hotel, :id => room_type} }
        it_should_behave_like "not authorized"
      end

      describe "POST create" do
        before { post :create, {:hotel_id => @hotel, :room_type => valid_attributes} }
        it_should_behave_like "not authorized"
      end

      describe "PUT update" do
        let(:room_type) { RoomType.make!(:hotel => @hotel) }
        before { put :update, {:hotel_id => @hotel, :room_type => valid_attributes, :id => room_type} }
        it_should_behave_like "not authorized"
      end

      describe "DELETE destroy" do
        let(:room_type) { RoomType.make!(:hotel => @hotel) }
        before { delete :destroy, {:hotel_id => @hotel, :id => room_type} }
        it_should_behave_like "not authorized"
      end
    end
  end
end
