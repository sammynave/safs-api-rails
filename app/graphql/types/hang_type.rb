# frozen_string_literal: true

module Types
  class HangType < Types::BaseObject
    field :id, ID, null: false
    field :start_at, GraphQL::Types::ISO8601DateTime, null: false
    field :end_at, GraphQL::Types::ISO8601DateTime, null: false

    field :owner, Types::UserType, null: false
    field :hang_type, Types::HangTypeType, null: false
    field :hang_participants, [Types::HangParticipantType], null: true
  end
end
