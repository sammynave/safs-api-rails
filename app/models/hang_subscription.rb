# frozen_string_literal: true

class HangSubscription < ApplicationRecord
  belongs_to :user
  belongs_to :hang_type
end
