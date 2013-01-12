class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new
    @user.roles.each { |role| send(role) }
  end

  def hotel_owner
    can :manage, Hotel do |hotel|
      hotel.belongs_to?(@user)
    end

    can :manage, RoomType, :hotel_id => @user.hotel_ids.concat([nil])
    can :manage, Room, :room_type_id => @user.room_type_ids.concat([nil])
  end
end
