# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :users, [Types::UserType], null: false

    def users
      ::User.all
    end

    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    def user(id:)
      ::User.find(id)
    end

    field :me, Types::UserType, null: false

    def me
      context[:current_user]
    end

    field :hangs, [Types::HangType], null: false

    def hangs
      ::Hang.all
    end

    field :upcoming_hangs, [Types::HangType], null: false

    def upcoming_hangs
      hang_type_ids = context[:current_user]
                      .hang_subscriptions
                      .pluck(:hang_type_id)

      hangs = ::Hang
              .where(hang_type_id: hang_type_ids)
              .where('hangs.start_at > ?', DateTime.now.beginning_of_day)
      hangs
    end

    field :my_hangs, [Types::HangType], null: false do
      argument :start_after, GraphQL::Types::ISO8601DateTime, required: false
      argument :start_before, GraphQL::Types::ISO8601DateTime, required: false
    end

    def my_hangs(start_after: nil, start_before: nil)
      if start_after
        return context[:current_user]
               .hangs
               .where('hangs.start_at > ?', start_after)
      end

      if start_before
        return context[:current_user]
               .hangs
               .where('hangs.start_at < ?', start_before)
      end

      if start_before && start_after
        return context[:current_user]
               .hangs
               .where('hangs.start_at > ? and hangs.end_at < ?', start_after, start_before)
      end

      context[:current_user].hangs
    end

    field :hang_types, [Types::HangTypeType], null: false

    def hang_types
      ::HangType.all
    end

    field :user_account, Types::UserAccountType, null: false do
      argument :id, ID, required: true
    end

    def user_account(id:)
      ::User.find(id)
    end
  end
end
