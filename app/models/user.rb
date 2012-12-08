class User < ActiveRecord::Base
  GENDERS = ["Male", "Female"]
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :phone, :gender, :date_of_birth

  validates :first_name, :last_name, :date_of_birth, :presence => true
  validates :gender, :inclusion => GENDERS

  def full_name
    "#{first_name} #{last_name}"
  end
end
