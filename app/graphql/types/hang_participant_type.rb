# frozen_string_literal: true

module Types
  class HangParticipantType < Types::BaseObject
    field :id, ID, null: false

    field :hang, Types::HangType, null: true
    field :user, Types::UserType, null: true

    def hang
      RecordLoader.for(::Hang).load(object.hang_id)
    end

    def user
      RecordLoader.for(::User).load(object.user_id)
    end
  end
end
