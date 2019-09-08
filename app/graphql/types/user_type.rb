module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :username, String, null: false

    field :hangs, [Types::HangType], null: true
    field :hang_subscriptions, [Types::HangSubscriptionType], null: true
    field :hang_participants, [Types::HangParticipantType], null: true
  end
end
