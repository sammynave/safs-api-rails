# frozen_string_literal: true

module Types
  class HangSubscriptionType < Types::BaseObject
    field :id, ID, null: false

    field :hang_type, Types::HangTypeType, null: true
    field :user, Types::UserType, null: true

    def hang_type
      RecordLoader.for(::HangType).load(object.hang_type_id)
    end

    def user
      RecordLoader.for(::User).load(object.user_id)
    end
  end
end
