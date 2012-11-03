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
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    if resource.update_without_password(params[resource_name])
      set_flash_message :notice, :updated if is_navigational_format?
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => after_update_path_for(resource)
    else
      clean_up_passwords(resource)
      respond_with_navigational(resource){ render :edit }
    end
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
