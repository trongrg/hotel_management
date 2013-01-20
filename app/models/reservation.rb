class Reservation < ActiveRecord::Base
  STATUSES = {:active => "Active", :expired => "Expired", :canceled => "Canceled"}
  attr_accessible :adults, :check_in_date, :check_out_date, :children, :currency,
    :prepaid_cents, :special_request, :status, :room_ids, :hotel_id,
    :guest_attributes

  monetize :prepaid_cents, :as => :prepaid, :allow_nil => true

  belongs_to :guest
  belongs_to :hotel
  has_and_belongs_to_many :rooms

  validates :guest, :status, :check_in_date, :hotel, :presence => true
  validates :status, :inclusion => STATUSES.values

  accepts_nested_attributes_for :guest

  after_initialize :set_default_status
  after_initialize :build_guest, :if => lambda { |record| record.guest.blank? }

  STATUSES.keys.each do |status|
    scope status, where(:status => STATUSES[status])
  end

  def prepaid_attributes=(attributes)
    return unless attributes.has_key?(:currency) && attributes.has_key?(:dollars)
    self.prepaid = Money.parse("#{attributes[:currency]}#{attributes[:dollars]}")
  end

  private
  def set_default_status
    self.status ||= STATUSES[:active]
  end
end
