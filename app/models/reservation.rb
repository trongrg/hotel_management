class Reservation < ActiveRecord::Base
  STATUS = {:active => "Active", :expired => "Expired"}
  belongs_to :room
  belongs_to :user
  belongs_to :guest

  monetize :prepaid_in_cents, :as => :prepaid, :allow_nil => true

  validates :room, :user, :guest, :status, :check_in_date, :check_out_date, :presence => true
  validates :status, :inclusion => STATUS.values

  accepts_nested_attributes_for :guest

  after_initialize :default_values
  before_update :check_status
  before_destroy :check_status

  scope :expired, :conditions => ['status = ?', STATUS[:expired]]
  scope :active, :conditions => ['status = ?', STATUS[:active]]

  def prepaid_attributes=(value)
    self.prepaid = Money.parse("#{value[:currency]}#{value[:dollars]}")
  end

  def expired?
    self.status == STATUS[:expired]
  end

  private
  def default_values
    self.status ||= STATUS[:active]
    self.guest ||= Guest.new
  end

  def check_status
    if self.status_was == STATUS[:expired]
      self.errors[:base] << "Cannot edit/delete expired reservation"
      return false
    else
      return true
    end
  end
end
