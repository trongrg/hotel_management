class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    authorize(user)
    can :show, User, :id => user.id
  end

  private
  def authorize(user)
    if user.role? :hotel_owner
      owner_authorization(user)
    end
    if user.role? :staff
      staff_authorization(user)
    end
  end

  def owner_authorization(user)
    can :manage, Hotel, :owner_id => user.id
    can :manage, RoomType, :hotel_id => user.hotels.map(&:id) + [nil]
    can :manage, Room, :room_type_id => RoomType.owned_by(user).map(&:id) + [nil]
    can :manage, Furnishing, :room_type_id => RoomType.owned_by(user).map(&:id) + [nil]
    can :manage, :staff
  end

  def staff_authorization(user)
    can :manage, Guest
    can :read, Hotel, :id => Hotel.managed_by(user).map(&:id) + [nil]
    can :read, Room, :id => Room.managed_by(user).map(&:id) + [nil]
    can :manage, CheckIn, :room_id => Room.managed_by(user).map(&:id) + [nil]
    can :manage, Reservation, :room_id => Room.managed_by(user).map(&:id) + [nil]
    can :manage, CheckOut, :room_id => Room.managed_by(user).map(&:id) + [nil]
  end
end
