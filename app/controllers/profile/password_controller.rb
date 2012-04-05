class Profile::PasswordController < ApplicationController
  before_filter :authenticate_user!
  layout 'application'
  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_with_password(params[:user])
      sign_in(@user, :bypass => true)
      redirect_to dashboard_path, :notice => t('record.updated', :record => t('model.password'))
    else
      render :edit
    end
  end
end
