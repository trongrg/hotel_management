class User < ActiveRecord::Base
  include RoleModel
  GENDERS = ["Male", "Female"]
  roles :hotel_owner, :staff_member
  roles_attribute :roles_mask
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :phone, :gender, :date_of_birth, :roles, :roles_mask

  validates :first_name, :last_name, :date_of_birth, :roles, :presence => true
  validates :gender, :inclusion => GENDERS

  def full_name
    "#{first_name} #{last_name}"
  end
end
