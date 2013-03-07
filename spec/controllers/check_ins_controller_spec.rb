require 'spec_helper'

describe CheckInsController do
  let(:user) { User.make!(:hotel_owner) }
  let(:hotel) { Hotel.make!(:owner => user) }
  let(:room_type) { RoomType.make!(:hotel => hotel) }
  let(:room) { Room.make!(:room_type => room_type) }
  let!(:check_in) { CheckIn.make!(:rooms => [room], :hotel => hotel) }
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
      :adults => 2,
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
      let(:action) { get :show, {:hotel_id => hotel.to_param, :id => check_in} }
      it_should_behave_like "unauthenticated"
    end

    describe "GET edit" do
      let(:action) { get :edit, {:hotel_id => hotel.to_param, :id => check_in} }
      it_should_behave_like "unauthenticated"
    end

    describe "POST create" do
      let(:action) { post :create, {:hotel_id => hotel, :check_in => valid_attributes} }
      it_should_behave_like "unauthenticated"
    end

    describe "PUT update" do
      let(:action) { put :update, {:hotel_id => hotel.to_param, :check_in => valid_attributes, :id => check_in} }
      it_should_behave_like "unauthenticated"
    end

    describe "DELETE destroy" do
      let(:action) { delete :destroy, {:hotel_id => hotel.to_param, :id => check_in} }
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
        let!(:expired_check_in) { CheckIn.make!(:expired, :rooms => [room], :hotel => hotel) }
        before { get :index, {:hotel_id => hotel.to_param, :status => status} }
        context "without status" do
          let(:status) { }
          it "assigns all check_ins as @check_ins" do
            assigns(:check_ins).should eq([check_in, expired_check_in])
          end
        end
        context "with active status" do
          let(:status) { "active" }
          it "assigns all active as @check_ins" do
            assigns(:check_ins).should eq([check_in])
          end
        end

        context "with expired status" do
          let(:status) { "expired" }
          it "assigns all expired as @check_ins" do
            assigns(:check_ins).should eq([expired_check_in])
          end
        end
      end

      describe "GET show" do
        before { get :show, {:hotel_id => hotel.to_param, :id => check_in.to_param} }
        it "assigns the requested check_in as @check_in" do
          assigns(:check_in).should eq(check_in)
        end
      end

      describe "GET new" do
        before { get :new, {:hotel_id => hotel.to_param} }
        it "assigns a new check_in as @check_in" do
          assigns(:check_in).should be_a_new(CheckIn)
        end
      end

      describe "GET edit" do
        before { get :edit, {:hotel_id => hotel.to_param, :id => check_in.to_param} }
        it "assigns the requested check_in as @check_in" do
          assigns(:check_in).should eq(check_in)
        end
      end

      describe "POST create" do
        describe "with valid params" do
          it "creates a new CheckIn" do
            expect {
              post :create, {:check_in => valid_attributes, :hotel_id => hotel.to_param }
            }.to change(CheckIn, :count).by(1)
          end

          it "assigns a newly created check_in as @check_in" do
            post :create, {:check_in => valid_attributes, :hotel_id => hotel.to_param }
            assigns(:check_in).should be_a(CheckIn)
            assigns(:check_in).should be_persisted
          end

          it "redirects to the created check_in" do
            post :create, {:check_in => valid_attributes, :hotel_id => hotel.to_param }
            response.should redirect_to([hotel, CheckIn.last])
          end
        end

        describe "with invalid params" do
          let!(:errors) { Reservation.create.errors }
          let(:action) { post :create, {:hotel_id => hotel.to_param, :check_in => { "status" => "invalid value" }} }
          before { CheckIn.any_instance.stub(:errors).and_return errors }
          it "assigns a newly created but unsaved check_in as @check_in" do
            assigns(:check_in).should be_a_new(CheckIn)
          end

          it "re-renders the 'new' template" do
            response.should render_template("new")
          end
        end
      end

      describe "PUT update" do
        context "with permission" do
          context "and valid params" do
            let(:action) { put :update, {:id => check_in.to_param, :hotel_id => hotel.to_param, :check_in => { "adults" => 1 }} }
            it "updates the requested check_in" do
              CheckIn.any_instance.should_receive(:update_attributes).with({ "adults" => "1" })
              put :update, {:id => check_in.to_param, :hotel_id => hotel.to_param, :check_in => { "adults" => 1 }}
            end

            it "assigns the requested check_in as @check_in" do
              assigns(:check_in).should eq(check_in)
            end

            it "redirects to the check_in" do
              response.should redirect_to([hotel, check_in])
            end
          end

          describe "with invalid params" do
            let!(:errors) { CheckIn.create.errors }
            let(:action) { put :update, {:id => check_in.to_param, :hotel_id => hotel.to_param, :check_in => { "status" => "invalid value" }} }
            before { Reservation.any_instance.stub(:errors).and_return errors }

            it "assigns the check_in as @check_in" do
              assigns(:check_in).should eq(check_in)
            end

            it "re-renders the 'edit' template" do
              response.should render_template("edit")
            end
          end
        end

        context "without permission" do
          let(:check_in) { CheckIn.make! }
          it "cannot find the check in" do
            expect {
              put :update, {:id => check_in.to_param, :hotel_id => hotel}
            }.to raise_error(ActiveRecord::RecordNotFound)
          end
        end
      end

      describe "DELETE destroy" do
        context "with permission" do
          it "destroys the requested check_in" do
            expect {
              delete :destroy, {:hotel_id => hotel.to_param, :id => check_in.to_param}
            }.to change(CheckIn, :count).by(-1)
          end

          it "redirects to the check_ins list" do
            delete :destroy, {:id => check_in.to_param, :hotel_id => hotel }
            response.should redirect_to(hotel_check_ins_url(hotel))
          end
        end

        context 'without permission' do
          let(:check_in) { CheckIn.make! }
          it "cannot find the check in" do
            expect {
              delete :destroy, {:id => check_in.to_param, :hotel_id => hotel }
            }.to raise_error(ActiveRecord::RecordNotFound)
          end
        end
      end
    end

    context "who does not own the hotel" do
      let(:hotel) { Hotel.make! }
      let(:check_in) { CheckIn.make!(:hotel => hotel) }

      describe "GET index" do
        let(:action) { get :index, {:hotel_id => hotel.to_param} }
        it_should_behave_like "unauthorized"
      end

      describe "GET show" do
        let(:action) { get :show, {:hotel_id => hotel.to_param, :id => check_in} }
        it_should_behave_like "unauthorized"
      end

      describe "GET edit" do
        let(:action) { get :edit, {:hotel_id => hotel.to_param, :id => check_in} }
        it_should_behave_like "unauthorized"
      end

      describe "POST create" do
        let(:action) { post :create, {:hotel_id => hotel.to_param, :check_in => valid_attributes} }
        it_should_behave_like "unauthorized"
      end

      describe "PUT update" do
        let(:action) { put :update, {:hotel_id => hotel.to_param, :room => valid_attributes, :id => check_in} }
        it_should_behave_like "unauthorized"
      end

      describe "DELETE destroy" do
        let(:action) { delete :destroy, {:hotel_id => hotel.to_param, :id => check_in} }
        it_should_behave_like "unauthorized"
      end
    end
  end
end
