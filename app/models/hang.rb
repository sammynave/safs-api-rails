# frozen_string_literal: true

class Hang < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  belongs_to :hang_type

  has_many :hang_participants

  validates :start_at, :end_at, presence: true
end
