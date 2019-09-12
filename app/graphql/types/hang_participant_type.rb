# frozen_string_literal: true

module Types
  class HangParticipantType < Types::BaseObject
    field :id, ID, null: false

    field :hang, Types::HangType, null: true
    field :user, Types::UserType, null: true
  end
end
