class CheckIn < ActiveRecord::Base
  STATUS = {:active => 'Active', :expired => 'Expired'}

  belongs_to :user
  belongs_to :room
  belongs_to :guest
  validates :status, :room, :guest, :user, :presence => true
  validates :status, :inclusion => STATUS.values

  monetize :prepaid_in_cents, :as => :prepaid, :allow_nil => true

  accepts_nested_attributes_for :guest

  before_update :check_status
  after_initialize :default_values
  before_destroy :check_status
  before_validation :check_room_occupation

  scope :expired, :conditions => ['status = ?', STATUS[:expired]]
  scope :active, :conditions => ['status = ?', STATUS[:active]]

  def prepaid_attributes=(value)
    self.prepaid = Money.parse("#{value[:currency]}#{value[:dollars]}")
  end

  private
  def default_values
    self.status ||= STATUS[:active]
    self.guest ||= Guest.new
  end

  def check_status
    if self.status_was == STATUS[:expired]
      self.errors[:base] << "Cannot edit/delete expired check in"
      return false
    else
      return true
    end
  end

  def check_room_occupation
    if self.room.present? && self.room.current_check_in.present? && self.room.current_check_in != self && self.status == STATUS[:active]
      self.errors[:base] << "Cannot check in to an occupied room"
      return false
    else
      return true
    end
  end
end
