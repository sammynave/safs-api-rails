class User < ApplicationRecord
  has_many :hangs
  has_many :hang_subscriptions
  has_many :hang_participants

  validates :username, uniqueness: true
  validates :email, uniqueness: true
  validates :phone, uniqueness: true
end
