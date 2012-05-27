class Room < ActiveRecord::Base
  belongs_to :room_type
  validates :number, :room_type, :presence => true
  has_many :check_ins
  has_many :reservations
  has_many :check_outs

  has_one :current_check_in, :class_name => "CheckIn", :conditions => ["check_ins.status = ?", CheckIn::STATUS[:active]]
end
