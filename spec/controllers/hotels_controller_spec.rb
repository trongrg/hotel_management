require 'spec_helper'

describe HotelsController do
  context "not signed in user" do
    it_should_only_allow_access_to_signed_in_user([:index, :show, :new, :create, :edit, :update, :destroy])
  end
  it_should_only_allow_access_to([:index, :show, :new, :create, :edit, :update, :destroy], [:admin, :hotel_owner])

  context "with signed in hotel owner" do
    let(:owner) { User.make!(:hotel_owner) }
    before do
      @hotel = Hotel.make!(:owner => owner)
      sign_in owner
    end

    # This should return the minimal set of attributes required to create a valid
    # Hotel. As you add validations to Hotel, be sure to
    # update the return value of this method accordingly.
    def valid_attributes
      {:name => "Hotel name", :phone_number => "0987654321", :lat => 10, :lng => 10}
    end

    describe "GET index" do
      it "returns http success" do
        get :index
        response.should be_success
      end

      it "assigns all owner's hotels as @hotels" do
        hotel = Hotel.make!
        get :index
        assigns(:hotels).should eq([@hotel])
      end
    end

    describe "GET show" do
      context "of his/her hotel" do
        it "assigns the requested hotel as @hotel" do
          get :show, {:id => @hotel.to_param}
          assigns(:hotel).should eq(@hotel)
        end
      end

      context "of other user's hotel" do
        before do
          hotel = Hotel.make!
          get :show, {:id => hotel.to_param}
        end

        it_should_behave_like "not authorized"
      end
    end

    describe "GET new" do
      it "assigns a new hotel as @hotel" do
        get :new
        assigns(:hotel).should be_a_new(Hotel)
      end
    end

    describe "GET edit" do
      context "of his/her hotel" do
        it "assigns the requested hotel as @hotel" do
          get :edit, {:id => @hotel.to_param}
          assigns(:hotel).should eq(@hotel)
        end
      end

      context "of other user's hotel" do
        before do
          hotel = Hotel.make!
          get :edit, {:id => hotel.to_param}
        end

        it_should_behave_like "not authorized"
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Hotel" do
          expect {
            post :create, {:hotel => valid_attributes}
          }.to change(Hotel, :count).by(1)
        end

        it "assigns a newly created hotel as @hotel" do
          post :create, {:hotel => valid_attributes}
          assigns(:hotel).should be_a(Hotel)
          assigns(:hotel).should be_persisted
        end

        it "redirects to the created hotel" do
          post :create, {:hotel => valid_attributes}
          response.should redirect_to(hotel_path(Hotel.last))
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved hotel as @hotel" do
          # Trigger the behavior that occurs when invalid params are submitted
          Hotel.any_instance.stub(:save).and_return(false)
          post :create, {:hotel => {}}
          assigns(:hotel).should be_a_new(Hotel)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Hotel.any_instance.stub(:save).and_return(false)
          post :create, {:hotel => {}}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      context "of his/her hotel" do
        describe "with valid params" do
          it "updates the requested hotel" do
            # Assuming there are no other hotels in the database, this
            # specifies that the Hotel created on the previous line
            # receives the :update_attributes message with whatever params are
            # submitted in the request.
            Hotel.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
            put :update, {:id => @hotel.to_param, :hotel => {'these' => 'params'}}
          end

          it "assigns the requested hotel as @hotel" do
            put :update, {:id => @hotel.to_param, :hotel => valid_attributes}
            assigns(:hotel).should eq(@hotel)
          end

          it "redirects to the hotel" do
            put :update, {:id => @hotel.to_param, :hotel => valid_attributes}
            response.should redirect_to(hotel_path(@hotel))
          end
        end

        describe "with invalid params" do
          it "assigns the hotel as @hotel" do
            hotel = Hotel.create! valid_attributes
            # Trigger the behavior that occurs when invalid params are submitted
            Hotel.any_instance.stub(:save).and_return(false)
            put :update, {:id => hotel.to_param, :hotel => {}}
            assigns(:hotel).should eq(hotel)
          end

          it "re-renders the 'edit' template" do
            # Trigger the behavior that occurs when invalid params are submitted
            Hotel.any_instance.stub(:save).and_return(false)
            put :update, {:id => @hotel.to_param, :hotel => {}}
            response.should render_template("edit")
          end
        end
      end

      context "of other user's hotel" do
        before do
          hotel = Hotel.make!
          put :update, {:id => hotel.to_param, :hotel => {}}
        end

        it_should_behave_like "not authorized"
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested hotel" do
        expect {
          delete :destroy, {:id => @hotel.to_param}
        }.to change(Hotel, :count).by(-1)
      end

      it "redirects to the hotels list" do
        delete :destroy, {:id => @hotel.to_param}
        response.should redirect_to(hotels_url)
      end
    end
  end
end
