# frozen_string_literal: true

class HangParticipant < ApplicationRecord
  belongs_to :user
  belongs_to :hang
end
