# frozen_string_literal: true

class Mutations::DeclineToParticipateInHang < Mutations::BaseMutation
  argument :hang_id, String, required: true

  field :hang_participant, Types::HangParticipantType, null: true
  field :upcoming_hangs, [Types::HangType], null: true

  def resolve(hang_id:)
    hang_participant = context[:current_user]
                       .hang_participants
                       .where(hang_id: hang_id)
                       .first
    if hang_participant.destroy!
      {
        upcoming_hangs: upcoming_hangs,
        errors: []
      }
    else
      {
        upcoming_hangs: nil,
        errors: hang_participant.errors.full_messages
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
