class AdminUser < ActiveRecord::Base
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :username

  before_destroy :ensure_last_admin

  private
  def ensure_last_admin
    if AdminUser.count > 1
      return true
    else
      self.errors[:base] << "Cannot delete last admin"
      return false
    end
  end
end
