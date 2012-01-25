class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to users_path, :notice => t('record.created', :record => t('model.user'))
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    any_passwords = %w(password password_confirmation).any? do |field|
      params[:user][field].present?
    end

    update_method = any_passwords ? :update_attributes : :update_without_password

    if @user.send(update_method, params[:user])
      redirect_to users_path, :notice => t('record.updated', :record => t('model.user'))
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])

    @user.destroy

    redirect_to users_path, :notice => t('record.deleted', :record => t('model.user'))
  end
end
