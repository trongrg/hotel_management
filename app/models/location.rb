class Location < ActiveRecord::Base
  belongs_to :locatable, :polymorphic => true
  attr_accessible :latitude, :longitude

  validates :latitude, :longitude, :presence => true

  def all_blank?
    [:latitude, :longitude].all? do |attr|
      self.send(attr).blank?
    end
  end

  def to_s
    [latitude, longitude].join(", ")
  end
end
