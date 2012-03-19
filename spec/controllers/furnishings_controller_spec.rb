require 'spec_helper'

describe FurnishingsController do
  context "with signed in user" do
    context "which has permission" do
      before(:each) do
        @user = User.make!(:hotel_owner)
        @hotel = Hotel.make!(:owner => @user)
        @room_type = RoomType.make!(:hotel => @hotel)
        sign_in @user
      end

      def valid_attributes
        { :name => "Bed", :price => 100, :room_type_id => @room_type.id }
      end

      describe "GET index" do
        it "assigns all accessible furnishings as @furnishings" do
          furnishing1 = Furnishing.create! valid_attributes
          furnishing2 = Furnishing.create! valid_attributes.merge!(:room_type_id => RoomType.make!(:hotel => @hotel))
          get :index, { :room_type_id => @room_type.to_param }
          assigns(:furnishings).should eq([furnishing1])
        end
      end

      describe "GET show" do
        it "assigns the requested furnishing as @furnishing" do
          furnishing = Furnishing.create! valid_attributes
          get :show, { :room_type_id => @room_type.to_param, :id => furnishing.to_param}
          assigns(:furnishing).should eq(furnishing)
        end
      end

      describe "GET new" do
        it "assigns a new furnishing as @furnishing" do
          get :new, { :room_type_id => @room_type.to_param }
          assigns(:furnishing).should be_a_new(Furnishing)
        end
      end

      describe "GET edit" do
        it "assigns the requested furnishing as @furnishing" do
          furnishing = Furnishing.create! valid_attributes
          get :edit, {:room_type_id => @room_type.to_param, :id => furnishing.to_param}
          assigns(:furnishing).should eq(furnishing)
        end
      end

      describe "POST create" do
        describe "with valid params" do
          it "creates a new Furnishing" do
            expect {
              post :create, {:room_type_id => @room_type.to_param, :furnishing => valid_attributes}
            }.to change(Furnishing, :count).by(1)
          end

          it "assigns a newly created furnishing as @furnishing" do
            post :create, {:room_type_id => @room_type.to_param, :furnishing => valid_attributes}
            assigns(:furnishing).should be_a(Furnishing)
            assigns(:furnishing).should be_persisted
          end

          it "redirects to the created furnishing" do
            post :create, {:room_type_id => @room_type.to_param, :furnishing => valid_attributes}
            response.should redirect_to(room_type_furnishing_path(@room_type, Furnishing.last))
          end
        end

        describe "with invalid params" do
          it "assigns a newly created but unsaved furnishing as @furnishing" do
            # Trigger the behavior that occurs when invalid params are submitted
            Furnishing.any_instance.stub(:save).and_return(false)
            post :create, {:room_type_id => @room_type.to_param, :furnishing => {}}
            assigns(:furnishing).should be_a_new(Furnishing)
          end

          it "re-renders the 'new' template" do
            # Trigger the behavior that occurs when invalid params are submitted
            Furnishing.any_instance.stub(:save).and_return(false)
            post :create, {:room_type_id => @room_type.to_param, :furnishing => {}}
            response.should render_template("new")
          end
        end
      end

      describe "PUT update" do
        describe "with valid params" do
          it "updates the requested furnishing" do
            furnishing = Furnishing.create! valid_attributes
            # Assuming there are no other furnishings in the database, this
            # specifies that the Furnishing created on the previous line
            # receives the :update_attributes message with whatever params are
            # submitted in the request.
            Furnishing.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
            put :update, {:room_type_id => @room_type.to_param, :id => furnishing.to_param, :furnishing => {'these' => 'params'}}
          end

          it "assigns the requested furnishing as @furnishing" do
            furnishing = Furnishing.create! valid_attributes
            put :update, {:room_type_id => @room_type.to_param, :id => furnishing.to_param, :furnishing => valid_attributes}
            assigns(:furnishing).should eq(furnishing)
          end

          it "redirects to the furnishing" do
            furnishing = Furnishing.create! valid_attributes
            put :update, {:room_type_id => @room_type.to_param, :id => furnishing.to_param, :furnishing => valid_attributes}
            response.should redirect_to(room_type_furnishing_path(@room_type, furnishing))
          end
        end

        describe "with invalid params" do
          it "assigns the furnishing as @furnishing" do
            furnishing = Furnishing.create! valid_attributes
            # Trigger the behavior that occurs when invalid params are submitted
            Furnishing.any_instance.stub(:save).and_return(false)
            put :update, {:room_type_id => @room_type.to_param, :id => furnishing.to_param, :furnishing => { :room_type_id => @room_type.to_param }}
            assigns(:furnishing).should eq(furnishing)
          end

          it "re-renders the 'edit' template" do
            furnishing = Furnishing.create! valid_attributes
            # Trigger the behavior that occurs when invalid params are submitted
            Furnishing.any_instance.stub(:save).and_return(false)
            put :update, {:room_type_id => @room_type.to_param, :id => furnishing.to_param, :furnishing => { :room_type_id => @room_type.to_param }}
            response.should render_template("edit")
          end
        end
      end

      describe "DELETE destroy" do
        it "destroys the requested furnishing" do
          furnishing = Furnishing.create! valid_attributes
          expect {
            delete :destroy, {:room_type_id => @room_type.to_param, :id => furnishing.to_param}
          }.to change(Furnishing, :count).by(-1)
        end

        it "redirects to the furnishings list" do
          furnishing = Furnishing.create! valid_attributes
          delete :destroy, {:room_type_id => @room_type.to_param, :id => furnishing.to_param}
          response.should redirect_to(room_type_furnishings_url(@room_type))
        end
      end

    end
    context "which does not have permission" do
      before do
        @owner = User.make!(:hotel_owner)
        @hotel = Hotel.make!
        @room_type = RoomType.make!(:hotel => @hotel)
        @furnishing = Furnishing.make!(:room_type => @room_type)
        sign_in @owner
      end

      describe "GET show" do
        before { get :show, :room_type_id => @room_type.id, :id => @furnishing }
        it_should_behave_like "not authorized"
      end

      describe "Get edit" do
        before { get :edit, :id => @furnishing.id, :room_type_id => @room_type.id }
        it_should_behave_like "not authorized"
      end

      describe "PUT update" do
        before { put :update, :id => @furnishing.id, :room_type_id => @room_type.id, :room_type => {} }
        it_should_behave_like "not authorized"
      end

      describe "DELETE destroy" do
        before { delete :destroy, :id => @furnishing.id, :room_type_id => @room_type.id }
        it_should_behave_like "not authorized"
      end
    end
  end
  context "with not signed in user" do
    describe "GET index" do
      before { get :index, :room_type_id => 1 }
      it_should_behave_like "not signed in"
    end
    describe "GET show" do
      before { get :show, :id => 1, :room_type_id => 1 }
      it_should_behave_like "not signed in"
    end
    describe "GET new" do
      before { get :new, :room_type_id => 1 }
      it_should_behave_like "not signed in"
    end
    describe "POST create" do
      before { post :create, :room_type_id => 1, :furnishing => {} }
      it_should_behave_like "not signed in"
    end
    describe "Get edit" do
      before { get :edit, :room_type_id => 1, :id => 1 }
      it_should_behave_like "not signed in"
    end
    describe "PUT update" do
      before { put :update, :room_type_id => 1, :id => 1, :furnishing => {} }
      it_should_behave_like "not signed in"
    end
    describe "DELETE destroy" do
      before { delete :destroy, :room_type_id => 1, :id => 1 }
      it_should_behave_like "not signed in"
    end
  end
end