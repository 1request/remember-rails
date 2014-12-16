class Location < ActiveRecord::Base
  has_many :group
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode  # auto-fetch address 
  geocoded_by :address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
end
