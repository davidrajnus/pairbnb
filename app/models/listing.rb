class Listing < ApplicationRecord
  mount_uploaders :listings, ListingUploader
  serialize :listings, JSON

  has_many :tags

  enum place_type: [:city, :kampong, :industrial]
end
