module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :users, [Types::UserType], null: false

    def users
      puts context[:current_user]
      User.all
    end

    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    def user(id:)
      puts context[:current_user]
      User.find(id)
    end

    field :hangs, [Types::HangType], null: false

    def hangs
      puts context[:current_user]
      Hang.all.map
    end
  end
end
