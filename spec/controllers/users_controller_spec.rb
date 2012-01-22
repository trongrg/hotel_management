require 'spec_helper'

describe UsersController do
  context "with signed in admin" do
    before do
      @admin = User.make!(:admin)
      @hotel_owner = User.make!(:hotel_owner)
      @staff = User.make!(:staff)
      @valid_attrs = { :first_name => "Trong", :last_name => "Tran", :username => "trongtran",
        :email => "trongrg@gmail.com", :password => "please", :password_confirmation => "please",
        :dob => {:"1i" => "1988", :"2i" => "December", :"3i" => "15"},
        :phone_number => "01694622095", :address1 => "702 Nguyen Van Linh", :address2 => "District 7",
        :state => "Ho Chi Minh City", :country => "Viet Nam", :zip_code => "12345"
      }
      sign_in @admin
    end

    describe "GET 'index'" do
      before do
        get :index
      end

      it "returns http success" do
        response.should be_success
      end

      it "renders 'index' template" do
        response.should render_template("index")
      end

      it "assigns all users as @users" do
        assigns(:users).should == User.all
      end
    end

    describe "GET 'show'" do
      before do
        get :show, :id => @hotel_owner.id
      end

      it "returns http success" do
        response.should be_success
      end

      it "renders 'show' template" do
        response.should render_template('show')
      end

      it "assigns the user as @user" do
        assigns(:user).should == @hotel_owner
      end
    end

    describe "GET 'new'" do
      before do
        get :new
      end

      it "returns http success" do
        response.should be_success
      end

      it "renders 'new' template" do
        response.should render_template('new')
      end

      it "assigns a new user as @user" do
        assigns(:user).should_not be_persisted
      end
    end

    describe "POST 'create'" do
      context "valid params" do
        it "creates a new user" do
          expect {
            post :create, :user => @valid_attrs
          }.to change(User, :count).by(1)
        end

        it "redirects to users page" do
          post :create, :user => @valid_attrs
          response.should redirect_to users_path
        end
      end

      context "invalid params" do
        before do
          post :create, :user => {}
        end

        it "returns http unprocessable entity" do
          response.status.should == 422
        end

        it "renders 'new' template" do
          response.should render_template('new')
        end
      end
    end

    describe "GET 'edit'" do
      before do
        get :edit, :id => @hotel_owner.id
      end

      it "returns http success" do
        response.should be_success
      end

      it "renders 'edit' template" do
        response.should render_template('edit')
      end

      it "assigns the user as @user" do
        assigns(:user).should == @hotel_owner
      end
    end

    describe "PUT 'update'" do
      context "with valid params" do
        before do
          get :update, :id => @hotel_owner.id, :user => {:first_name => "new first name"}
        end

        it "updates the user" do
          @hotel_owner.reload.first_name.should == "new first name"
        end

        it "redirects to users page" do
          response.should redirect_to users_path
        end
      end

      context "with invalid params" do
        it "does not update the user" do
          expect {
            put :update, :id => @hotel_owner.id, :user => {:username => ""}
          }.not_to change(@hotel_owner, :first_name)
        end

        it "renders 'edit' template" do
          put :update, :id => @hotel_owner.id, :user => {:username => ""}
          response.should render_template('edit')
        end

        it "assigns the user as @user" do
          put :update, :id => @hotel_owner.id, :user => {:username => ""}
          assigns(:user).should == @hotel_owner
        end
      end
    end

    describe "DELETE 'destroy'" do
      it "destroys the user" do
        expect {
          delete :destroy, :id => @staff.id
        }.to change(User, :count).by(-1)
        User.find_by_id(@staff.id).should be_nil
      end

      it "redirects to users page" do
        delete :destroy, :id => @staff.id
        response.should redirect_to users_path
      end
    end
  end

  shared_examples_for "not authorize" do
    it "redirects to sign in page" do
      response.should redirect_to new_user_session_path
    end

    it "shows not authorize message" do
      flash[:alert].should == "You need to sign in or sign up before continuing."
    end
  end

  shared_examples_for "not have permission" do
    it "redirects to dashboard page" do
      response.should redirect_to dashboard_path
    end

    it "shows not have permission message" do
      flash[:alert].should == "You are not authorized to access this page."
    end
  end

  context "with not signed in user" do
    describe "GET 'index'" do
      before do
        get :index
      end

      it_should_behave_like "not authorize"
    end

    describe "GET 'show'" do
      before do
        get :show, :id => 1
      end

      it_should_behave_like "not authorize"
    end

    describe "GET 'new'" do
      before do
        get :new
      end

      it_should_behave_like "not authorize"
    end

    describe "POST 'create'" do
      before do
        post :create, :user => @valid_attrs
      end

      it_should_behave_like "not authorize"
    end

    describe "GET 'edit'" do
      before do
        get :edit, :id => 1
      end

      it_should_behave_like "not authorize"
    end

    describe "PUT 'update'" do
      before do
        put :update, :id => 1
      end

      it_should_behave_like "not authorize"
    end

    describe "DELETE 'destroy'" do
      before do
        delete :destroy, :id => 1
      end

      it_should_behave_like "not authorize"
    end
  end

  context "with signed in user" do
    before do
      @user = User.make!(:staff)
      @another_user = User.make!(:staff)
      @valid_attrs = { :first_name => "Trong", :last_name => "Tran", :username => "trongtran",
        :email => "trongrg@gmail.com", :password => "please", :password_confirmation => "please",
        :dob => {:"1i" => "1988", :"2i" => "December", :"3i" => "15"},
        :phone_number => "01694622095", :address1 => "702 Nguyen Van Linh", :address2 => "District 7",
        :state => "Ho Chi Minh City", :country => "Viet Nam", :zip_code => "12345"
      }
      sign_in @user
    end

    describe "GET 'index'" do
      before do
        get :index
      end

      it_should_behave_like "not have permission"
    end

    describe "GET 'show'" do
      context "his/her page" do
        before do
          get :show, :id => @user.id
        end

        it "returns http success" do
          response.should be_success
        end

        it "renders 'show' template" do
          response.should render_template('show')
        end

        it "assigns the user as @user" do
          assigns(:user).should == @user
        end
      end

      context "another user's page" do
        before do
          get :show, :id => @another_user.id
        end

        it_should_behave_like "not have permission"
      end
    end

    describe "GET 'new'" do
      before do
        get :new
      end

      it_should_behave_like "not have permission"
    end

    describe "POST 'create'" do
      before do
        post :create, :user => {}
      end

      it_should_behave_like "not have permission"
    end

    describe "GET 'edit'" do
      before do
        get :edit, :id => @user.id
      end

      it_should_behave_like "not have permission"
    end

    describe "PUT 'update'" do
      before do
        put :update, :id => @another_user.id, :user => {}
      end

      it_should_behave_like "not have permission"
    end

    describe "DELETE 'destroy'" do
      before do
        delete :destroy, :id => @another_user.id
      end

      it_should_behave_like "not have permission"
    end
  end
end
