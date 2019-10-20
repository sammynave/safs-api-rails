# frozen_string_literal: true

class Mutations::ParticipateInHang < Mutations::BaseMutation
  argument :hang_id, String, required: true

  field :hang_participant, Types::HangParticipantType, null: true
  field :upcoming_hangs, [Types::HangType], null: true

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
        upcoming_hangs: upcoming_hangs,
        errors: []
      }
    else
      {
        hang_participant: nil,
        upcoming_hangs: upcoming_hangs,
        errors: hang.errors.full_messages
      }
    end
  end

  def upcoming_hangs
    hang_type_ids = context[:current_user]
                    .hang_subscriptions
                    .pluck(:hang_type_id)

    hangs = ::Hang
            .where(hang_type_id: hang_type_ids)
            .where('hangs.start_at > ?', DateTime.now.beginning_of_day)
    hangs
  end
end
