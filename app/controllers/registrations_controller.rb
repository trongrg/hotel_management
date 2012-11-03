class RegistrationsController < Devise::RegistrationsController
  layout :determine_layout

  def new
    super
  end

  def create
    super
  end

  def edit
    super
  end

  def update
    super
  end

  protected
  def determine_layout
    case action_name
    when 'new'
      'guess'
    when 'edit'
      'application'
    end
  end

  def after_update_path_for(resource)
    dashboard_path
  end
end
