class HangParticipant < ApplicationRecord
  belongs_to :user
  belongs_to :hang_type
end
