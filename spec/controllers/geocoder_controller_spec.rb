require 'spec_helper'

describe GeocoderController do
  sign_in_user

  describe "GET 'get_location'" do
    context "location found" do
      before do
        Geocoder.should_receive(:coordinates).and_return "result"
        get 'get_location', :format => :json
      end

      it "returns http success" do
        response.should be_success
      end

      it "returns the first result" do
        response.body.should == "result"
      end
    end

    context "location not found" do
      before do
        Geocoder.should_receive(:coordinates).and_return []
        get 'get_location', :format => :json
      end

      it "return 404" do
        response.status.should == 404
      end

      it "returns empty response" do
        response.body.should == ""
      end
    end
  end

  describe "GET 'get_address'" do
    context "location found" do
      before do
        address = mock("Address")
        address.stub(:address_components).and_return "address_components"
        Geocoder.should_receive(:search).and_return [address]
        get 'get_address', :format => :json
      end

      it "returns http success" do
        response.should be_success
      end

      it "returns the first result" do
        response.body.should == "address_components"
      end
    end

    context "location not found" do
      before do
        Geocoder.should_receive(:search).and_return []
        get 'get_address', :format => :json
      end

      it "returns 404" do
        response.status.should == 404
      end

      it "returns empty response" do
        response.body.should == ""
      end
    end
  end
end
