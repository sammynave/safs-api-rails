# frozen_string_literal: true

class HangType < ApplicationRecord
  has_many :hangs
  has_many :hang_subscriptions

  validates :name, uniqueness: true
end
