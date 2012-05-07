class Guest < ActiveRecord::Base
  validates :first_name, :last_name, :national_id_number, :presence => true

  def full_name
    "#{first_name} #{last_name}"
  end
end
