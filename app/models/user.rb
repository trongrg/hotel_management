class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,
    :remember_me, :username, :first_name, :last_name,
    :phone_number, :address1, :address2, :state, :country, :zip, :dob

  validates :username, :dob, :presence => true
  validates :username, :format => { :with => /^\w+$/, :message => "is invalid. Only letters, digits and underscores are allowed." }
end
