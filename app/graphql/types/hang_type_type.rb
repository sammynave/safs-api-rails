# frozen_string_literal: true

module Types
  class HangTypeType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false

    field :hangs, [Types::HangType], null: true
    field :hang_subscriptions, [Types::HangSubscriptionType], null: true

    def hangs
      RelatedRecordLoader.for(::Hang, 'hang_type_id').load(object.id)
    end

    def hang_subscriptions
      RelatedRecordLoader.for(::HangSubscription, 'hang_type_id').load(object.id)
    end
  end
end
