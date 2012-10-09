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
    :phone_number, :dob, :roles, :role_ids, :address_attributes

  has_and_belongs_to_many :roles

  belongs_to :address
  has_many :hotels, :foreign_key => :owner_id
  has_many :working_hotels, :through => :hotels_users, :source => :hotel
  has_many :hotels_users

  validates :username, :dob, :roles, :role_ids, :presence => true
  validates :username, :format => { :with => /^[\w\.]+$/, :message => "is invalid. Only letters, digits, periods and underscores are allowed." }


  accepts_nested_attributes_for :address
  after_initialize :init_address

  def role?(role)
    !!self.roles.find_by_name(role.to_s.titleize)
  end

  def full_name
    [first_name, last_name].join(" ")
  end

  def role_names
    roles.map(&:name).sort
  end

  protected
  def init_address
    self.address ||= Address.new
  end
end
