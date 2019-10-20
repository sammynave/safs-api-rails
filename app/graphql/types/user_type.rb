# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :username, String, null: false

    field :hangs, [Types::HangType], null: true
    field :hang_subscriptions, [Types::HangSubscriptionType], null: true
    field :hang_participants, [Types::HangParticipantType], null: true

    def hangs
      RelatedRecordLoader.for(::Hang, 'user_id').load(object.id)
    end

    def hang_subscription
      RelatedRecordLoader.for(::HangSubscription, 'user_id').load(object.id)
    end

    def hang_participants
      RelatedRecordLoader.for(::HangParticipant, 'user_id').load(object.id)
    end
  end
end
