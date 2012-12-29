describe Ability do
  context "hotel owner" do
    it "is able to manage his/her hotels" do
      owner = User.make(:hotel_owner)
      hotel = Hotel.new
      hotel.owner = owner
      owner.should have_ability(:manange, :for => hotel)
    end
    it "is able to create new hotel" do
      owner = User.make(:hotel_owner)
      owner.should have_ability(:create, :for => Hotel.new)
    end
  end
end
