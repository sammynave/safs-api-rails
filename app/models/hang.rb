class Hang < ApplicationRecord
  belongs_to :owner
  belongs_to :hang_type
  has_many :hang_participants
end
