# frozen_string_literal: true

class Mutations::ParticipateInHang < Mutations::BaseMutation
  argument :hang_id, String, required: true

  field :hang_participant, Types::HangParticipantType, null: true

  def resolve(hang_id:)
    user = context[:current_user]
    hang = Hang.find(hang_id)
    hang_participant = HangParticipant.new(
      user: user,
      hang: hang
    )
    if hang_participant.save
      {
        hang_participant: hang_participant,
        errors: []
      }
    else
      {
        hang_participant: nil,
        errors: hang.errors.full_messages
      }
    end
  end
end
