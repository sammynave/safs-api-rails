# frozen_string_literal: true

module Types
  class HangTypeType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false

    field :hangs, [Types::HangType], null: true
    field :hang_subscriptions, [Types::HangSubscriptionType], null: true
  end
end
