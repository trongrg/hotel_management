class RolesConstraint
  def initialize(*roles)
    @roles = roles
  end

  def matches?(request)
    user = request.env['warden'].try(:user)
    return unless user
    @roles.map(&:to_s).select { |r| user.roles.map(&:name).include? r.titleize }.count > 0
  end
end
