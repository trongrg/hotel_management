class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
    user ||= User.new
    if user.role? :admin
      can :manage, :all
      can :manage, :staff
    elsif user.role? :hotel_owner
      can :manage, Hotel, :owner_id => user.id
      can :manage, RoomType do |room_type|
        user.hotels.include?(room_type.hotel) || room_type.hotel.nil?
      end
      can :manage, Room do |room|
        user.hotels.map(&:room_types).flatten.include?(room.room_type) || room.room_type.blank?
      end
      can :manage, Furnishing do |furnishing|
        user.hotels.map(&:room_types).flatten.include?(furnishing.room_type) || furnishing.room_type.blank?
      end
      can :manage, :staff
    end
    can :show, User, :id => user.id
  end
end
