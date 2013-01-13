require 'spec_helper'

describe HotelsController do
  let(:user) { User.make!(:hotel_owner) }
  let!(:hotel) { Hotel.make!(:owner => user) }
  let(:action) { }
  let(:valid_attributes) do
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

  context "unauthenticated user" do
    before { action }
    describe "GET index" do
      let(:action) { get :index, {:id => hotel.to_param} }
      it_should_behave_like "unauthenticated"
    end

    describe "GET show" do
      let(:action) { get :show, {:id => hotel.to_param} }
      it_should_behave_like "unauthenticated"
    end

    describe "GET edit" do
      let(:action) { get :edit, {:id => hotel.to_param} }
      it_should_behave_like "unauthenticated"
    end

    describe "POST create" do
      let(:action) { post :create, {:id => hotel, :hotel => valid_attributes} }
      it_should_behave_like "unauthenticated"
    end

    describe "PUT update" do
      let(:action) { put :update, {:id => hotel.to_param, :hotel => valid_attributes} }
      it_should_behave_like "unauthenticated"
    end

    describe "DELETE destroy" do
      let(:action) { delete :destroy, {:id => hotel.to_param} }
      it_should_behave_like "unauthenticated"
    end
  end

  context "authenticated user" do
    before do
      sign_in user
      action
    end

    describe "GET index" do
      let(:action) { get :index }
      it "returns http success" do
        response.should be_success
      end

      it "assigns all owner's hotels as @hotels" do
        assigns(:hotels).should == [hotel]
      end
    end

    describe "GET show" do
      let(:action) { get :show, :id => hotel.to_param }
      context "of his/her hotel" do
        it "assigns the requested hotel as @hotel" do
          assigns(:hotel).should == hotel
        end
      end

      context "of other's hotel" do
        let(:hotel) { Hotel.make! }
        it_should_behave_like "unauthorized"
      end
    end

    describe "GET new" do
      let(:action) { get :new }
      it "assigns a new hotel as @hotel" do
        assigns(:hotel).should be_a_new(Hotel)
      end
    end

    describe "GET edit" do
      let(:action) { get :edit, {:id => hotel.to_param} }
      context "of his/her hotel" do
        it "assigns the requested hotel as @hotel" do
          assigns(:hotel).should == hotel
        end
      end

      context "of other's hotel" do
        let(:hotel) { Hotel.make! }
        it_should_behave_like "unauthorized"
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
        let!(:errors) { Hotel.create.errors }
        before { Hotel.any_instance.stub(:errors).and_return errors }
        it "assigns a newly created but unsaved hotel as @hotel" do
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
        context "with valid params" do
          let(:action) { put :update, {:id => hotel.to_param, :hotel => valid_attributes} }
          it "updates the requested hotel" do
            Hotel.any_instance.should_receive(:update_attributes).with({'these' => 'params'}).and_return(true)
            put :update, :id => @hotel.to_param, :hotel => {'these' => 'params'}
          end

          it "assigns the requested hotel as @hotel" do
            assigns(:hotel).should == hotel
          end

          it "redirects to the created hotel page" do
            response.should redirect_to(hotel.reload)
          end
        end

        describe "with invalid params" do
          let!(:errors) { Hotel.create.errors }
          before { Hotel.any_instance.stub(:errors).and_return errors }

          it "assigns the hotel as @hotel" do
            put :update, {:id => hotel.to_param, :hotel => {}}
            assigns(:hotel).should == hotel
          end

          it "re-renders the 'edit' template" do
            put :update, {:id => hotel.to_param, :hotel => {}}
            response.should render_template("edit")
          end
        end
      end

      context "of other's hotel" do
        let(:hotel) { Hotel.make! }
        let(:action) { get :show, :id => hotel.to_param }

        it_should_behave_like "unauthorized"
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested hotel" do
        expect {
          delete :destroy, {:id => hotel.to_param}
        }.to change(Hotel, :count).by(-1)
      end

      it "redirects to hotels list" do
        delete :destroy, {:id => hotel.to_param}
        response.should redirect_to(hotels_url)
      end
    end
  end
end
