shared_examples_for "unauthenticated" do
  it "redirects to sign in page" do
    response.should redirect_to new_user_session_path
  end

  it "shows not signed in message" do
    flash[:alert].should == "You need to sign in or sign up before continuing."
  end
end

shared_examples_for "unauthorized" do
  it "redirects to homepage" do
    response.should redirect_to root_path
  end

  it "shows not have permission message" do
    flash[:alert].should == "You are not authorized to access this page."
  end
end
