class Listing < ApplicationRecord
  mount_uploaders :images, ListingUploader
  serialize :images, JSON

  has_many :tags, :dependent => :destroy
  has_many :bookings, :dependent => :destroy

  enum place_type: [:city, :kampong, :industrial]
end
