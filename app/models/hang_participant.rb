class HangParticipant < ApplicationRecord
  belongs_to :user
  belongs_to :hang
end
