class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :invitable

  has_many :invitations, :class_name => 'User', :foreign_key => 'invited_by_id'

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,
    :remember_me, :username, :first_name, :last_name,
    :phone_number, :address1, :address2, :state, :country, :zip_code, :dob, :city,
    :roles, :role_ids

  validates :username, :dob, :roles, :role_ids, :presence => true
  validates :username, :format => { :with => /^[\w\.]+$/, :message => "is invalid. Only letters, digits, periods and underscores are allowed." }

  has_and_belongs_to_many :roles
  has_many :hotels, :foreign_key => :owner_id

  def role?(role)
    !!self.roles.find_by_name(role.to_s.titleize)
  end

  def address
    [address1, address2, city, state, country, zip_code].join(" ")
  end

  def full_name
    [first_name, last_name].join(" ")
  end
end
