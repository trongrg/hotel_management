require 'spec_helper'

describe RoomTypesController do
  let(:user) { User.make!(:hotel_owner) }
  let(:hotel) { Hotel.make! }
  let!(:room_type) { RoomType.make!(:hotel => hotel)}
  let(:valid_attributes) { { "name" => "MyString", :hotel_id => hotel.id } }
  let(:action) { }

  context "unauthenticated user" do
    before { action }
    describe "GET index" do
      let(:action) { get :index, {:hotel_id => hotel.to_param} }
      it_should_behave_like "unauthenticated"
    end

    describe "GET show" do
      let(:action) { get :show, {:hotel_id => hotel.to_param, :id => room_type.to_param} }
      it_should_behave_like "unauthenticated"
    end

    describe "GET edit" do
      let(:action) { get :edit, {:hotel_id => hotel.to_param, :id => room_type.to_param} }
      it_should_behave_like "unauthenticated"
    end

    describe "POST create" do
      let(:action) { post :create, {:hotel_id => hotel, :room => valid_attributes} }
      it_should_behave_like "unauthenticated"
    end

    describe "PUT update" do
      let(:action) { put :update, {:hotel_id => hotel.to_param, :room => valid_attributes, :id => room_type.to_param} }
      it_should_behave_like "unauthenticated"
    end

    describe "DELETE destroy" do
      let(:action) { delete :destroy, {:hotel_id => hotel.to_param, :id => room_type.to_param} }
      it_should_behave_like "unauthenticated"
    end
  end

  context "with authenticated user" do
    before do
      sign_in user
      action
    end

    context "who owns the hotel" do
      let(:hotel) { Hotel.make!(:owner => user) }

      describe "GET index" do
        let(:action) { get :index, :hotel_id => hotel.to_param }
        it "assigns all room_types as @room_types" do
          assigns(:room_types).should == [room_type]
        end
      end

      describe "GET show" do
        context "with permission" do
          let(:action) { get :show, {:id => room_type.to_param, :hotel_id => hotel.to_param} }
          it "assigns the requested room_type as @room_type" do
            assigns(:room_type).should == room_type
          end
        end

        context 'without permission' do
          let(:room_type) { RoomType.make! }
          it "cannot find the room type" do
            expect {
              get :show, {:id => room_type.to_param, :hotel_id => hotel}
            }.to raise_error(ActiveRecord::RecordNotFound)
          end
        end
      end

      describe "GET new" do
        let(:action) { get :new, { :hotel_id => hotel.to_param } }
        it "assigns a new room_type as @room_type" do
          assigns(:room_type).should be_a_new(RoomType)
        end
      end

      describe "GET edit" do
        context "with permission" do
          let(:action) { get :edit, {:id => room_type.to_param, :hotel_id => hotel.to_param} }
          it "assigns the requested room_type as @room_type" do
            assigns(:room_type).should == room_type
          end
        end

        context 'without permission' do
          let(:room_type) { RoomType.make! }
          it "cannot find the room type" do
            expect {
              get :edit, {:id => room_type.to_param, :hotel_id => hotel.to_param}
            }.to raise_error(ActiveRecord::RecordNotFound)
          end
        end
      end

      describe "POST create" do
        describe "with valid params" do
          it "creates a new RoomType" do
            expect {
              post :create, {:room_type => valid_attributes, :hotel_id => hotel}
            }.to change(RoomType, :count).by(1)
          end

          it "assigns a newly created room_type as @room_type" do
            post :create, {:room_type => valid_attributes, :hotel_id => hotel}
            assigns(:room_type).should be_a(RoomType)
            assigns(:room_type).should be_persisted
          end

          it "redirects to newly created room type" do
            post :create, {:room_type => valid_attributes, :hotel_id => hotel}
            response.should redirect_to(hotel_room_type_path(hotel, assigns(:room_type)))
          end
        end

        describe "with invalid params" do
          let!(:errors) { RoomType.create.errors }
          before { RoomType.any_instance.stub(:errors).and_return errors }

          it "assigns a newly created but unsaved room_type as @room_type" do
            post :create, {:room_type => {:hotel_id => hotel.to_param}, :hotel_id => hotel}
            assigns(:room_type).should be_a_new(RoomType)
          end

          it "re-renders the 'new' template" do
            post :create, {:room_type => {:hotel_id => hotel.to_param}, :hotel_id => hotel}
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
              put :update, {:id => room_type.to_param, :room_type => {'these' => 'params'}, :hotel_id => hotel}
            end

            it "assigns the requested room_type as @room_type" do
              put :update, {:id => room_type.to_param, :room_type => valid_attributes, :hotel_id => hotel}
              assigns(:room_type).should == room_type
            end

            it "redirects to updated room type" do
              put :update, {:id => room_type.to_param, :room_type => valid_attributes, :hotel_id => hotel}
              response.should redirect_to(hotel_room_type_path(hotel, room_type))
            end
          end

          describe "with invalid params" do
            let!(:errors) { RoomType.create.errors }
            before { RoomType.any_instance.stub(:errors).and_return errors }

            it "assigns the room_type as @room_type" do
              put :update, {:id => room_type.to_param, :room_type => {}, :hotel_id => hotel}
              assigns(:room_type).should == room_type
            end

            it "re-renders the 'edit' template" do
              put :update, {:id => room_type.to_param, :room_type => {}, :hotel_id => hotel}
              response.should render_template("edit")
            end
          end
        end

        context 'without permission' do
          let(:room_type) { RoomType.make! }
          it "cannot find the room type" do
            expect {
              get :update, {:id => room_type.to_param, :hotel_id => hotel, :room_type => {} }
            }.to raise_error(ActiveRecord::RecordNotFound)
          end
        end
      end

      describe "DELETE destroy" do
        context "with permission" do
          it "destroys the requested room_type" do
            expect {
              delete :destroy, {:id => room_type.to_param, :hotel_id => hotel}
            }.to change(RoomType, :count).by(-1)
          end

          it "redirects to room types list" do
            delete :destroy, {:id => room_type.to_param, :hotel_id => hotel}
            response.should redirect_to(hotel_room_types_url)
          end
        end
      end

      context 'without permission' do
        let(:room_type) { RoomType.make! }
        it "cannot find the room type" do
          expect {
            get :update, {:id => room_type.to_param, :hotel_id => hotel, :room_type => {} }
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context "who does not own the hotel" do
      let(:hotel) { Hotel.make! }

      describe "GET index" do
        let(:action) { get :index, {:hotel_id => hotel} }
        it_should_behave_like "unauthorized"
      end

      describe "GET show" do
        let(:action) { get :show, {:hotel_id => hotel, :id => room_type} }
        it_should_behave_like "unauthorized"
      end

      describe "GET edit" do
        let(:action) { get :edit, {:hotel_id => hotel, :id => room_type} }
        it_should_behave_like "unauthorized"
      end

      describe "POST create" do
        let(:action) { post :create, {:hotel_id => hotel, :room_type => valid_attributes} }
        it_should_behave_like "unauthorized"
      end

      describe "PUT update" do
        let(:action) { put :update, {:hotel_id => hotel, :room_type => valid_attributes, :id => room_type} }
        it_should_behave_like "unauthorized"
      end

      describe "DELETE destroy" do
        let(:action) { delete :destroy, {:hotel_id => hotel, :id => room_type} }
        it_should_behave_like "unauthorized"
      end
    end
  end
end
