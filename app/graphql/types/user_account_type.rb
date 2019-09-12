# frozen_string_literal: true

module Types
  class UserAccountType < Types::BaseObject
    field :id, ID, null: false
    field :username, String, null: false
    field :phone, String, null: false
    field :email, String, null: false

    field :hangs, [Types::HangType], null: true
    field :hang_subscriptions, [Types::HangSubscriptionType], null: true
    field :hang_participants, [Types::HangParticipantType], null: true

    def self.authorized?(object, context)
      object == context[:current_user]
    end
  end
end
