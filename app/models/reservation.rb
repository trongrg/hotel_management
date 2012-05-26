class Reservation < ActiveRecord::Base
  STATUS = {:active => "Active", :expired => "Expired"}
  belongs_to :room
  belongs_to :user
  belongs_to :guest

  composed_of :prepaid,
    :class_name => "Money",
    :mapping => [%w(prepaid_in_cents cents), %w(currency currency_as_string)],
    :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },
    :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }

  validates :room, :user, :guest, :status, :check_in_date, :check_out_date, :presence => true
  validates :status, :inclusion => STATUS.values

  accepts_nested_attributes_for :guest

  after_initialize :default_values
  before_update :check_status
  before_destroy :check_status

  scope :expired, :conditions => ['status = ?', STATUS[:expired]]
  scope :active, :conditions => ['status = ?', STATUS[:active]]

  def prepaid_attributes=(value)
    self.prepaid = "#{value[:currency]}#{value[:dollars]}"
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
      self.errors[:base] << "Cannot edit/delete expired check in"
      return false
    end
  end
end
