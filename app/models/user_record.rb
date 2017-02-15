class UserRecord < ApplicationRecord
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  has_secure_password
  validates :password, :length => { :minimum => 6 }
  validates_confirmation_of :password

  def name=(val)
    write_attribute(:name, val.to_s.titleize)
  end
end
