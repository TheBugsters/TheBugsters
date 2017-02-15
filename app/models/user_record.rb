class UserRecord < ApplicationRecord
  validates :name, presence: true, :on => :create
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, :on => :create
  has_secure_password
  validates :password, :length => { :minimum => 6 }
  validates_confirmation_of :password, :on => :create

  def name=(val)
    write_attribute(:name, val.to_s.titleize)
  end
end
