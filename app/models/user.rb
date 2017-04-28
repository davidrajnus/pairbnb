class User < ApplicationRecord
  include Clearance::User

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: /.+@.+\.com/ }

  has_many :authentications, :dependent => :destroy
  has_many :listings

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
end

