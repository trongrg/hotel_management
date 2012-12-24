class Users::RegistrationsController < Devise::RegistrationsController
  def update
    self.resource = current_user

    if resource.update_without_password(resource_params)
      set_flash_message(:notice, :updated) if is_navigational_format?
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
end
