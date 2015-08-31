class User < ActiveRecord::Base
  has_secure_password

  has_many :comments
  has_many :events, dependent: :destroy
  has_many :joins, dependent: :destroy
  has_many :events_joined, through: :joins, source: :events

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :location, :state, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
end
