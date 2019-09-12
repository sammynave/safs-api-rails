# frozen_string_literal: true

module Types
  class HangSubscriptionType < Types::BaseObject
    field :id, ID, null: false

    field :hang_type, Types::HangTypeType, null: true
    field :user, Types::UserType, null: true
  end
end
