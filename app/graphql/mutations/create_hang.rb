# frozen_string_literal: true

class Mutations::CreateHang < Mutations::BaseMutation
  argument :hang_type_id, String, required: true
  argument :start_at, GraphQL::Types::ISO8601DateTime, required: true
  argument :end_at, GraphQL::Types::ISO8601DateTime, required: true

  field :hang, Types::HangType, null: true
  field :my_hangs, [Types::HangType], null: false do
    argument :start_after, GraphQL::Types::ISO8601DateTime, required: false
    argument :start_before, GraphQL::Types::ISO8601DateTime, required: false
  end
  field :errors, [String], null: true

  def self.authorized?(_object, context)
    context[:current_user].is_a?(User)
  end

  def resolve(hang_type_id:, start_at:, end_at:, start_before: nil, start_after: Time.now.iso8601)
    hang_type = HangType.find(hang_type_id)
    user = context[:current_user]
    hang = Hang.new(
      owner: user,
      hang_type: hang_type,
      start_at: start_at,
      end_at: end_at
    )
    if hang.save
      # Successful creation, return the created object with no errors
      {
        hang: hang,
        my_hangs: user.hangs.where('hangs.start_at > ?', start_after),
        errors: []
      }
    else
      # Failed save, return the errors to the client
      {
        hang: nil,
        my_hangs: nil,
        errors: hang.errors.full_messages
      }
    end
  end
end
