require 'spec_helper'

describe HotelsController do
  context "with signed in hotel owner" do
    let(:owner) { User.make!(:hotel_owner) }
    before do
      @hotel = Hotel.make!(:owner => owner)
      sign_in owner
    end

    def valid_attributes
      {
        :name => "Hotel name", :phone => "0987654321",
        :location_attributes => {
          :latitude => 10,
          :longitude => 10
        },
        :address_attributes =>
        {
          :line1 => "72 Nguyen Van Linh",
          :city => "Ho Chi Minh City",
          :country => "VN"
        }
      }
    end

    describe "GET index" do
      it "returns http success" do
        get :index
        response.should be_success
      end

      it "assigns all owner's hotels as @hotels" do
        hotel = Hotel.make!
        get :index
        assigns(:hotels).should == [@hotel]
      end
    end

    describe "GET show" do
      context "of his/her hotel" do
        it "assigns the requested hotel as @hotel" do
          get :show, {:id => @hotel.to_param}
          assigns(:hotel).should == @hotel
        end
      end

      context "of other's hotel" do
        let(:hotel) { Hotel.make! }
        before { get :show, :id => hotel.to_param }
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

      context "of other's hotel" do
        let(:hotel) { Hotel.make! }
        before { get :show, :id => hotel.to_param }
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

        it "redirects to the created hotel page" do
          post :create, {:hotel => valid_attributes}
          response.should redirect_to(assigns(:hotel))
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved hotel as @hotel" do
          # Trigger the behavior that occurs when invalid params are submitted
          post :create, {:hotel => {}}
          assigns(:hotel).should be_a_new(Hotel)
        end

        it "re-renders the 'new' template" do
          post :create, {:hotel => {}}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      context "of his/her hotel" do
        describe "with valid params" do
          it "updates the requested hotel" do
            Hotel.any_instance.should_receive(:update_attributes).with({'these' => 'params'}).and_return(true)
            put :update, :id => @hotel.to_param, :hotel => {'these' => 'params'}
          end

          it "assigns the requested hotel as @hotel" do
            put :update, {:id => @hotel.to_param, :hotel => valid_attributes}
            assigns(:hotel).should == @hotel
          end

          it "redirects to the created hotel page" do
            put :update, {:id => @hotel.to_param, :hotel => valid_attributes}
            response.should redirect_to(@hotel.reload)
          end
        end

        describe "with invalid params" do
          it "assigns the hotel as @hotel" do
            hotel = Hotel.make!(:owner => owner)
            # Trigger the behavior that occurs when invalid params are submitted
            errors = Hotel.create.errors
            Hotel.any_instance.stub(:errors).and_return(errors)
            put :update, {:id => hotel.to_param, :hotel => {}}
            assigns(:hotel).should == hotel
          end

          it "re-renders the 'edit' template" do
            # Trigger the behavior that occurs when invalid params are submitted
            errors = Hotel.create.errors
            Hotel.any_instance.stub(:errors).and_return(errors)
            put :update, {:id => @hotel.to_param, :hotel => {}}
            response.should render_template("edit")
          end
        end
      end

      context "of other's hotel" do
        let(:hotel) { Hotel.make! }
        before { get :show, :id => hotel.to_param }

        it_should_behave_like "not authorized"
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested hotel" do
        expect {
          delete :destroy, {:id => @hotel.to_param}
        }.to change(Hotel, :count).by(-1)
      end

      it "redirects to hotels list" do
        delete :destroy, {:id => @hotel.to_param}
        response.should redirect_to(hotels_url)
      end
    end
  end
end
