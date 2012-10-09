class RolesConstraint
  def initialize(*roles)
    @roles = roles
  end

  def matches?(request)
    user = request.env['warden'].try(:user)
    if user.is_a?(User)
      return @roles.map(&:to_s).select { |r| user.role? r }.count > 0
    elsif user.is_a?(AdminUser)
      return true
    end
  end
end
