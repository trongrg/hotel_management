class Guest < ActiveRecord::Base
  GENDERS = ["Male", "Female"]
  attr_accessible :first_name, :gender, :last_name, :passport, :phone
  validates :first_name, :last_name, :presence => true
  validates :gender, :inclusion => GENDERS, :allow_nil => true

  def full_name
    "#{first_name} #{last_name}"
  end
end
