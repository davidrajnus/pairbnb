class Listing < ApplicationRecord
  mount_uploaders :avatars, AvatarUploader
  serialize :avatars, JSON

  has_many :tags

  enum place_type: [:city, :kampong, :industrial]
end
