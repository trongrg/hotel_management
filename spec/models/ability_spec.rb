describe Ability do
  let(:owner) { User.make!(:hotel_owner) }
  let(:hotel) { Hotel.make!(:owner => owner) }
  let(:room_type) { RoomType.make!(:hotel => hotel) }
  let(:room) { Room.make!(:room_type => room_type) }
  let(:reservation) { Reservation.make!(:hotel => hotel) }
  let(:staff_member) { User.make!(:staff_member, :working_hotels => [hotel]) }
  context "hotel owner" do

    it "is able to create any thing" do
      owner.should have_ability(:create, :for => :all)
    end

    it "is able to manage his/her hotels" do
      owner.should have_ability(:manange, :for => hotel)
    end

    it "is able to manage room type" do
      owner.should have_ability(:manage, :for => room_type)
    end

    it "is able to manage room" do
      owner.should have_ability(:manage, :for => room)
    end

    it "is able to manage reservation" do
      owner.should have_ability(:manage, :for => reservation)
    end
  end

  context "staff member" do
    it "is able to read his/her working hotels" do
      staff_member.should have_ability(:read, :for => hotel)
    end

    it "is able to create reservation" do
      staff_member.should have_ability(:create, :for => Reservation)
    end

    it "is able to manage reservation" do
      staff_member.should have_ability(:manage, :for => reservation)
    end
  end
end
