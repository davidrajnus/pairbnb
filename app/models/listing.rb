class Listing < ApplicationRecord
  mount_uploaders :images, ListingUploader
  serialize :images, JSON

  has_many :tags, :dependent => :destroy
  has_many :bookings, :dependent => :destroy

  enum place_type: [:city, :kampong, :industrial]

  scope :country_filter, -> (country){where country: country}
  scope :min_filter, -> (min) {where('price > ?', min)} 
  scope :max_filter, -> (max) {where('price < ?', max)} 
end
