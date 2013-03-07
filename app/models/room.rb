class Room < ActiveRecord::Base
  attr_accessible :name, :room_type_id

  # associations
  belongs_to :room_type
  has_one :hotel, :through => :room_type
  has_and_belongs_to_many :reservations
  has_and_belongs_to_many :check_ins

  # validations
  validates :name, :room_type, :presence => true

  # scope
  scope :available,
    where{available == true}

  def current_check_in
    reload.check_ins.active.first
  end
end
