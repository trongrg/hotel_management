class Room < ActiveRecord::Base
  belongs_to :room_type
  validates :number, :room_type, :presence => true
  has_many :check_ins
  has_many :reservations
  has_many :check_outs

  has_one :current_check_in, :class_name => "CheckIn", :conditions => ["check_ins.status = ?", CheckIn::STATUS[:active]]

  scope :owned_by, lambda { |owner|
    joins( :room_type => { :hotel => :owner } ).
      where("users.id = ?", owner.id)
  }

  scope :managed_by, lambda { |staff|
    joins( :room_type => { :hotel => :staff_members }).
      where('users.id = ?', staff.id)
  }
end
