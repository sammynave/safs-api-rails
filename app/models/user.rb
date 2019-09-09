class User < ApplicationRecord
  has_secure_password

  has_many :hangs, foreign_key: "owner_id"
  has_many :hang_subscriptions
  has_many :hang_participants

  validates :username, :email, :phone, uniqueness: true, presence: true

  # validate formats as well
end
