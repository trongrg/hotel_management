describe Ability do
  context "hotel owner" do
    let(:owner) { User.make!(:hotel_owner) }
    let(:hotel) { Hotel.make!(:owner => owner) }
    let(:room_type) { RoomType.make!(:hotel => hotel) }
    let(:room) { Room.make!(:room_type => room_type) }
    it "is able to manage his/her hotels" do
      owner.should have_ability(:manange, :for => hotel)
    end

    it "is able to create new hotel" do
      owner.should have_ability(:create, :for => Hotel.new)
    end

    it "is able to manage room type" do
      owner.should have_ability(:manage, :for => room_type)
    end

    it "is able to create new room type" do
      owner.should have_ability(:create, :for => RoomType.new)
    end

    it "is able to manage room" do
      owner.should have_ability(:manage, :for => room)
    end

    it "is able to create new room" do
      owner.should have_ability(:create, :for => Room.new)
    end
  end
end
