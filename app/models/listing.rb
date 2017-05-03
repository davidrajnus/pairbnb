class Listing < ApplicationRecord
  mount_uploaders :listings, ListingUploader
  serialize :listings, JSON

  has_many :tags
  has_many :bookings

  enum place_type: [:city, :kampong, :industrial]
end
