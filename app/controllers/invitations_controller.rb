class InvitationsController < Devise::InvitationsController
  layout 'guess'

  def new
    super
  end
end
