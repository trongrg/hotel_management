class Users::PasswordController < ApplicationController
  before_filter :authenticate_user!
  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_with_password(params[:user])
      sign_in(@user, :bypass => true)
      redirect_to after_sign_in_path_for(@user), :notice => t('record.updated', :record => t('model.password'))
    else
      render :edit
    end
  end
end

