class Address < ActiveRecord::Base
  belongs_to :addressable, :polymorphic => true
  attr_accessible :addressable_id, :addressable_type, :city, :line1, :line2, :state, :zip, :country

  validates :line1, :city, :country, :presence => true

  def all_blank?
    [:line1, :line2, :city, :state, :zip, :country].all? do |attr|
      self.send(attr).blank?
    end
  end
end
