class Guest < ActiveRecord::Base
  GENDERS = {:female => "Female", :male => "Male"}
  validates :first_name, :last_name, :passport, :presence => true
  validates :gender, :inclusion => GENDERS.values

  def full_name
    "#{first_name} #{last_name}"
  end
end
