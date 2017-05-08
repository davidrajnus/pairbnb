class User < ApplicationRecord
  include Clearance::User
  
  # this is for the carrierwave image uploader gem
  mount_uploader :avatar, AvatarUploader


  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: /.+@.+\.com/ }

  # this links the user account to the authentication table for the Auth gem
  has_many :authentications, :dependent => :destroy
  has_many :listings, :dependent => :destroy
  has_many :bookings, :dependent => :destroy

  enum gender: [:male, :female]

  #assigns a user account an authorization role for a num of 0-3
  enum user_role: [:customer, :host, :admin, :superadmin]

  #this login variable helps to control the password_optional? method depending on
  #if the login is done using FB (no password required) vs through the app (password required)
  @@login = false

  def self.create_with_auth_and_hash(authentication, auth_hash)
    @@login = true
    user = User.create!(username: auth_hash["name"], email: auth_hash["extra"]["raw_info"]["email"])
    user.authentications << (authentication)
    return user
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def password_optional?
    if @@login
      @@login = false
      return true
    else
      return false
    end
  end

  def full_name
    self.first_name + " " + self.last_name
  end

end

