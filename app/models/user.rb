class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,
    :remember_me, :username, :first_name, :last_name,
    :phone_number, :address1, :address2, :state, :country, :zip_code, :dob, :city

  validates :username, :dob, :presence => true
  validates :username, :format => { :with => /^[\w\.]+$/, :message => "is invalid. Only letters, digits, periods and underscores are allowed." }

  has_and_belongs_to_many :roles

  def role?(role)
    !!self.roles.find_by_name(role.to_s.camelize)
  end
end
